// Exact-build U-01 localization registration/control-flow inventory. Static only.
// @category ITL
import ghidra.app.script.GhidraScript;
import ghidra.framework.Application;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.listing.InstructionIterator;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.mem.MemoryBlock;
import ghidra.program.model.scalar.Scalar;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.symbol.ReferenceIterator;
import ghidra.program.model.symbol.Symbol;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class U01LocalizationFlow extends GhidraScript {
    private static final String EXPECTED_SHA256 =
        "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b";
    private static final long WRAPPER_RVA = 0x1fb500L;
    private static final long DESCRIPTOR_RVA = 0x19fd810L;
    private static final long NEWER_ENTRY_RVA = 0x19fd7c0L;
    private static final long INVALID_ENTRY_RVA = 0x19fd7d0L;
    private static final long POINTER_SLOT_RVA = 0x1949d58L;
    private static final long REGISTRATION_DICTIONARY_RVA = 0x211aeb8L;
    private static final long DICTIONARY_CREATE_MUTABLE_SLOT_RVA = 0x192f340L;
    private static final long DICTIONARY_ADD_VALUE_SLOT_RVA = 0x192f5e8L;

    private static String hex(long value) {
        return String.format(Locale.ROOT, "0x%x", value);
    }

    private Map<String, Object> referenceRow(Reference reference) {
        Map<String, Object> row = new LinkedHashMap<>();
        Address from = reference.getFromAddress();
        Address to = reference.getToAddress();
        row.put("from_va", from.toString(true));
        row.put("from_rva", hex(from.getOffset() - currentProgram.getImageBase().getOffset()));
        row.put("to_va", to.toString(true));
        row.put("to_rva", hex(to.getOffset() - currentProgram.getImageBase().getOffset()));
        row.put("reference_type", reference.getReferenceType().toString());
        row.put("operand_index", reference.getOperandIndex());
        row.put("source_type", reference.getSource().toString());
        MemoryBlock block = currentProgram.getMemory().getBlock(from);
        row.put("from_memory_block", block == null ? null : block.getName());
        row.put("from_executable_block", block != null && block.isExecute());
        Function function = currentProgram.getFunctionManager().getFunctionContaining(from);
        row.put("from_function_entry_rva", function == null ? null :
            hex(function.getEntryPoint().getOffset() - currentProgram.getImageBase().getOffset()));
        row.put("from_function_name", function == null ? null : function.getName());
        return row;
    }

    private List<Object> referencesTo(Address address) {
        List<Object> rows = new ArrayList<>();
        ReferenceIterator references = currentProgram.getReferenceManager().getReferencesTo(address);
        while (references.hasNext()) {
            rows.add(referenceRow(references.next()));
        }
        return rows;
    }

    private Map<String, Object> referenceCountsTo(Address address) {
        Map<String, Object> counts = new LinkedHashMap<>();
        long total = 0;
        long calls = 0;
        long jumps = 0;
        long executableSources = 0;
        ReferenceIterator references = currentProgram.getReferenceManager().getReferencesTo(address);
        while (references.hasNext()) {
            Reference reference = references.next();
            total++;
            if (reference.getReferenceType().isCall()) calls++;
            if (reference.getReferenceType().isJump()) jumps++;
            MemoryBlock sourceBlock = currentProgram.getMemory().getBlock(reference.getFromAddress());
            if (sourceBlock != null && sourceBlock.isExecute()) executableSources++;
        }
        counts.put("total", total);
        counts.put("call", calls);
        counts.put("jump", jumps);
        counts.put("executable_source", executableSources);
        return counts;
    }

    private List<Object> symbolsAt(Address address) {
        List<Object> names = new ArrayList<>();
        Symbol[] symbols = currentProgram.getSymbolTable().getSymbols(address);
        for (Symbol symbol : symbols) {
            names.add(symbol.getName(true));
        }
        return names;
    }

    private Map<String, Object> addressSummary(Address address) throws Exception {
        Map<String, Object> row = new LinkedHashMap<>();
        MemoryBlock block = currentProgram.getMemory().getBlock(address);
        row.put("va", address.toString(true));
        row.put("rva", hex(address.getOffset() - currentProgram.getImageBase().getOffset()));
        row.put("memory_block", block == null ? null : block.getName());
        row.put("block_execute", block != null && block.isExecute());
        row.put("symbols", symbolsAt(address));
        row.put("reference_counts", referenceCountsTo(address));
        row.put("references_to", referencesTo(address));
        return row;
    }

    private Map<String, Object> instructionRow(Instruction instruction) {
        Map<String, Object> row = new LinkedHashMap<>();
        long base = currentProgram.getImageBase().getOffset();
        row.put("va", instruction.getAddress().toString(true));
        row.put("rva", hex(instruction.getAddress().getOffset() - base));
        row.put("mnemonic", instruction.getMnemonicString());
        List<Object> operands = new ArrayList<>();
        for (int i = 0; i < instruction.getNumOperands(); i++) {
            operands.add(instruction.getDefaultOperandRepresentation(i));
        }
        row.put("operands", operands);
        List<Object> references = new ArrayList<>();
        for (Reference reference : instruction.getReferencesFrom()) {
            Map<String, Object> ref = referenceRow(reference);
            Address target = reference.getToAddress();
            ref.put("target_symbols", symbolsAt(target));
            references.add(ref);
        }
        row.put("references_from", references);
        return row;
    }

    private List<Object> wrapperInstructions(Function wrapper) {
        List<Object> rows = new ArrayList<>();
        InstructionIterator instructions = currentProgram.getListing().getInstructions(wrapper.getBody(), true);
        while (instructions.hasNext()) {
            rows.add(instructionRow(instructions.next()));
        }
        return rows;
    }

    private List<Object> immediateUses(long... values) throws Exception {
        List<Object> rows = new ArrayList<>();
        InstructionIterator instructions = currentProgram.getListing().getInstructions(true);
        while (instructions.hasNext()) {
            monitor.checkCancelled();
            Instruction instruction = instructions.next();
            for (int operand = 0; operand < instruction.getNumOperands(); operand++) {
                for (Object object : instruction.getOpObjects(operand)) {
                    if (!(object instanceof Scalar)) {
                        continue;
                    }
                    long value = ((Scalar) object).getUnsignedValue();
                    boolean wanted = false;
                    for (long expected : values) {
                        if (value == expected) {
                            wanted = true;
                            break;
                        }
                    }
                    if (!wanted) {
                        continue;
                    }
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("value", hex(value));
                    row.put("operand_index", operand);
                    row.put("instruction", instructionRow(instruction));
                    rows.add(row);
                }
            }
        }
        return rows;
    }

    private List<Object> pointerNeighbors(Address slot, int radius) throws Exception {
        List<Object> rows = new ArrayList<>();
        Memory memory = currentProgram.getMemory();
        long base = currentProgram.getImageBase().getOffset();
        for (int delta = -radius; delta <= radius; delta++) {
            Address cell = slot.add((long) delta * 8L);
            long value = memory.getLong(cell);
            Address target = toAddr(value);
            MemoryBlock targetBlock = memory.getBlock(target);
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("relative_index", delta);
            row.put("slot_va", cell.toString(true));
            row.put("slot_rva", hex(cell.getOffset() - base));
            row.put("target_va", target.toString(true));
            row.put("target_rva", hex(value - base));
            row.put("target_memory_block", targetBlock == null ? null : targetBlock.getName());
            row.put("target_executable", targetBlock != null && targetBlock.isExecute());
            Function function = currentProgram.getFunctionManager().getFunctionAt(target);
            row.put("target_function", function == null ? null : function.getName());
            row.put("target_function_entry", function != null);
            rows.add(row);
        }
        return rows;
    }

    private static String escape(String value) {
        StringBuilder out = new StringBuilder();
        out.append('"');
        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            switch (c) {
                case '"': out.append("\\\""); break;
                case '\\': out.append("\\\\"); break;
                case '\b': out.append("\\b"); break;
                case '\f': out.append("\\f"); break;
                case '\n': out.append("\\n"); break;
                case '\r': out.append("\\r"); break;
                case '\t': out.append("\\t"); break;
                default:
                    if (c < 0x20) {
                        out.append(String.format(Locale.ROOT, "\\u%04x", (int) c));
                    } else {
                        out.append(c);
                    }
            }
        }
        out.append('"');
        return out.toString();
    }

    private static String json(Object value, int indent) {
        if (value == null) return "null";
        if (value instanceof String) return escape((String) value);
        if (value instanceof Number || value instanceof Boolean) return value.toString();
        String pad = "  ".repeat(indent);
        String childPad = "  ".repeat(indent + 1);
        if (value instanceof Map<?, ?>) {
            StringBuilder out = new StringBuilder("{\n");
            boolean first = true;
            for (Map.Entry<?, ?> entry : ((Map<?, ?>) value).entrySet()) {
                if (!first) out.append(",\n");
                first = false;
                out.append(childPad).append(escape(entry.getKey().toString())).append(": ")
                    .append(json(entry.getValue(), indent + 1));
            }
            out.append("\n").append(pad).append("}");
            return out.toString();
        }
        if (value instanceof Iterable<?>) {
            StringBuilder out = new StringBuilder("[\n");
            boolean first = true;
            for (Object child : (Iterable<?>) value) {
                if (!first) out.append(",\n");
                first = false;
                out.append(childPad).append(json(child, indent + 1));
            }
            out.append("\n").append(pad).append("]");
            return out.toString();
        }
        return escape(value.toString());
    }

    public void run() throws Exception {
        String[] args = getScriptArgs();
        if (args.length != 1) {
            throw new IllegalArgumentException("usage: U01LocalizationFlow.java <output-json>");
        }
        String actualSha256 = currentProgram.getExecutableSHA256();
        if (actualSha256 == null || !EXPECTED_SHA256.equalsIgnoreCase(actualSha256)) {
            throw new IllegalStateException("unexpected executable SHA-256: " + actualSha256);
        }

        long base = currentProgram.getImageBase().getOffset();
        Address wrapperAddress = toAddr(base + WRAPPER_RVA);
        Address descriptorAddress = toAddr(base + DESCRIPTOR_RVA);
        Address newerAddress = toAddr(base + NEWER_ENTRY_RVA);
        Address invalidAddress = toAddr(base + INVALID_ENTRY_RVA);
        Address pointerSlot = toAddr(base + POINTER_SLOT_RVA);
        Address registrationDictionary = toAddr(base + REGISTRATION_DICTIONARY_RVA);
        Address dictionaryCreateMutableSlot = toAddr(base + DICTIONARY_CREATE_MUTABLE_SLOT_RVA);
        Address dictionaryAddValueSlot = toAddr(base + DICTIONARY_ADD_VALUE_SLOT_RVA);
        Function wrapper = currentProgram.getFunctionManager().getFunctionAt(wrapperAddress);
        if (wrapper == null) {
            wrapper = currentProgram.getFunctionManager().getFunctionContaining(wrapperAddress);
        }
        if (wrapper == null || !wrapper.getEntryPoint().equals(wrapperAddress)) {
            throw new IllegalStateException("wrapper function was not recovered at RVA " + hex(WRAPPER_RVA));
        }
        long pointerValue = currentProgram.getMemory().getLong(pointerSlot);
        if (pointerValue != wrapperAddress.getOffset()) {
            throw new IllegalStateException(
                "expected wrapper pointer missing at RVA " + hex(POINTER_SLOT_RVA) +
                "; found " + hex(pointerValue));
        }

        long functionCount = 0;
        FunctionIterator functions = currentProgram.getFunctionManager().getFunctions(true);
        while (functions.hasNext()) {
            functions.next();
            functionCount++;
        }

        Map<String, Object> root = new LinkedHashMap<>();
        root.put("schema", "windows-itl.u01-ghidra-localization-flow-20260927.v2");
        root.put("classification", "derived static metadata only; no Apple bytes retained");
        Map<String, Object> tool = new LinkedHashMap<>();
        tool.put("name", "Ghidra");
        tool.put("version", Application.getApplicationVersion());
        tool.put("analysis_mode", "full headless static analysis; target executable never launched");
        root.put("tool", tool);
        Map<String, Object> executable = new LinkedHashMap<>();
        executable.put("name", currentProgram.getName());
        executable.put("sha256", actualSha256.toLowerCase(Locale.ROOT));
        executable.put("image_base", hex(base));
        executable.put("function_count", functionCount);
        executable.put("binary_retained", false);
        root.put("executable", executable);

        Map<String, Object> wrapperRow = addressSummary(wrapperAddress);
        wrapperRow.put("function_name", wrapper.getName());
        wrapperRow.put("entry_va", wrapper.getEntryPoint().toString(true));
        wrapperRow.put("entry_rva", hex(WRAPPER_RVA));
        wrapperRow.put("body_address_count", wrapper.getBody().getNumAddresses());
        wrapperRow.put("instructions", wrapperInstructions(wrapper));
        root.put("group_0x1f42_wrapper", wrapperRow);

        Map<String, Object> pointerRow = addressSummary(pointerSlot);
        pointerRow.put("stored_target_va", hex(pointerValue));
        pointerRow.put("stored_target_rva", hex(pointerValue - base));
        pointerRow.put("neighbors", pointerNeighbors(pointerSlot, 8));
        root.put("wrapper_pointer_table_slot", pointerRow);

        root.put("group_descriptor", addressSummary(descriptorAddress));
        root.put("newer_version_member_entry", addressSummary(newerAddress));
        root.put("invalid_library_member_entry", addressSummary(invalidAddress));
        root.put("registration_dictionary_global", addressSummary(registrationDictionary));
        root.put("dictionary_create_mutable_indirect_slot", addressSummary(dictionaryCreateMutableSlot));
        root.put("dictionary_add_value_indirect_slot", addressSummary(dictionaryAddValueSlot));
        root.put("instruction_immediate_uses", immediateUses(
            0x1f42L, 0x1f420003L, 0x1f420004L));

        Map<String, Object> wrapperReferenceCounts = referenceCountsTo(wrapperAddress);
        Map<String, Object> descriptorReferenceCounts = referenceCountsTo(descriptorAddress);
        Map<String, Object> newerReferenceCounts = referenceCountsTo(newerAddress);
        Map<String, Object> invalidReferenceCounts = referenceCountsTo(invalidAddress);
        Map<String, Object> limits = new LinkedHashMap<>();
        limits.put("wrapper_reference_counts", wrapperReferenceCounts);
        limits.put("descriptor_reference_counts", descriptorReferenceCounts);
        limits.put("newer_member_entry_reference_counts", newerReferenceCounts);
        limits.put("invalid_member_entry_reference_counts", invalidReferenceCounts);
        limits.put("direct_call_reference_to_wrapper_identified",
            ((Number) wrapperReferenceCounts.get("call")).longValue() > 0);
        limits.put("wrapper_classification",
            "generated_localization_group_registration_initializer");
        limits.put("parser_result_or_status_comparison_identified", false);
        limits.put("member_3_vs_4_selection_branch_identified", false);
        limits.put("semantic_status_code_claimed", false);
        limits.put("concrete_non_label_incompatibility_theory_identified", false);
        limits.put("native_launch_authorized", false);
        limits.put("u01_status", "open");
        root.put("bounded_conclusion", limits);

        Path output = Path.of(args[0]);
        Files.createDirectories(output.toAbsolutePath().getParent());
        Files.writeString(output, json(root, 0) + "\n", StandardCharsets.UTF_8);
        println("U01_LOCALIZATION_FLOW_DONE output=" + output + " sha256=" + actualSha256);
    }
}
