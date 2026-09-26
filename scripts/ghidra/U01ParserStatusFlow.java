// Exact-build U-01 parser/status/resource bridge. Static only.
// @category ITL
import ghidra.app.script.GhidraScript;
import ghidra.framework.Application;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.listing.InstructionIterator;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.scalar.Scalar;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.symbol.ReferenceIterator;
import ghidra.program.model.symbol.Symbol;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class U01ParserStatusFlow extends GhidraScript {
    private static final String EXPECTED_SHA256 =
        "0aa1b53af915fc9e0ced4c7ecbcb1397a036d38367d894ae063ae1d127331f9b";
    private static final long PARSER_RVA = 0x10ad0b0L;
    private static final long DIRECT_CALLER_RVA = 0x53d500L;
    private static final long UPSTREAM_WRAPPER_RVA = 0x53f4e0L;
    private static final long ALTERNATE_PARSER_RVA = 0x10f4b90L;
    private static final long STATUS_FORMATTER_RVA = 0xebbf20L;
    private static final long DESCRIPTOR_MAPPER_RVA = 0xbfac90L;
    private static final long GROUP_WRAPPER_RVA = 0x1fb550L;
    private static final long GROUP_DESCRIPTOR_RVA = 0x19fd7e8L;
    private static final long GROUP_ENTRIES_RVA = 0x19fd7b8L;
    private static final long REGISTRATION_DICTIONARY_RVA = 0x211aeb8L;
    private static final long DICTIONARY_GET_VALUE_SLOT_RVA = 0x192f780L;
    private static final long STATUS_U32 = 0xfffffc94L;
    private static final long GROUP_ID = 0x1f43L;
    private long base;

    private static String hex(long value) {
        return String.format(Locale.ROOT, "0x%x", value);
    }

    private static String u32hex(int value) {
        return String.format(Locale.ROOT, "0x%08x", Integer.toUnsignedLong(value));
    }

    private Address at(long rva) {
        return toAddr(base + rva);
    }

    private String rva(Address address) {
        return hex(address.getOffset() - base);
    }

    private Function requireFunction(long expectedEntryRva) {
        Function function = currentProgram.getFunctionManager().getFunctionAt(at(expectedEntryRva));
        if (function == null) {
            function = currentProgram.getFunctionManager().getFunctionContaining(at(expectedEntryRva));
        }
        if (function == null || function.getEntryPoint().getOffset() != base + expectedEntryRva) {
            throw new IllegalStateException(
                "function entry not recovered at RVA " + hex(expectedEntryRva));
        }
        return function;
    }

    private List<Object> symbolsAt(Address address) {
        List<String> names = new ArrayList<>();
        for (Symbol symbol : currentProgram.getSymbolTable().getSymbols(address)) {
            names.add(symbol.getName(true));
        }
        Collections.sort(names);
        return new ArrayList<Object>(names);
    }

    private Map<String, Object> referenceRow(Reference reference) {
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("from_rva", rva(reference.getFromAddress()));
        row.put("to_rva", rva(reference.getToAddress()));
        row.put("reference_type", reference.getReferenceType().toString());
        row.put("operand_index", reference.getOperandIndex());
        Function owner = currentProgram.getFunctionManager().getFunctionContaining(
            reference.getFromAddress());
        row.put("from_function_entry_rva", owner == null ? null : rva(owner.getEntryPoint()));
        row.put("from_function_name", owner == null ? null : owner.getName());
        return row;
    }

    private List<Object> callReferencesTo(Function function) {
        List<Reference> refs = new ArrayList<>();
        ReferenceIterator iterator = currentProgram.getReferenceManager().getReferencesTo(
            function.getEntryPoint());
        while (iterator.hasNext()) {
            Reference reference = iterator.next();
            if (reference.getReferenceType().isCall()) {
                refs.add(reference);
            }
        }
        refs.sort(Comparator.comparingLong(r -> r.getFromAddress().getOffset()));
        List<Object> rows = new ArrayList<>();
        for (Reference reference : refs) {
            rows.add(referenceRow(reference));
        }
        return rows;
    }

    private Map<String, Object> functionRow(Function function) {
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("entry_rva", rva(function.getEntryPoint()));
        row.put("name", function.getName());
        row.put("body_address_count", function.getBody().getNumAddresses());
        List<Object> calls = callReferencesTo(function);
        row.put("direct_call_reference_count", calls.size());
        row.put("direct_call_references", calls);
        return row;
    }

    private Map<String, Object> instructionRow(Instruction instruction) {
        if (instruction == null) {
            throw new IllegalStateException("required instruction was not recovered");
        }
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("rva", rva(instruction.getAddress()));
        row.put("mnemonic", instruction.getMnemonicString());
        List<Object> operands = new ArrayList<>();
        for (int i = 0; i < instruction.getNumOperands(); i++) {
            operands.add(instruction.getDefaultOperandRepresentation(i));
        }
        row.put("operands", operands);
        List<Reference> refs = new ArrayList<>(Arrays.asList(instruction.getReferencesFrom()));
        refs.sort(Comparator.comparingLong(r -> r.getToAddress().getOffset()));
        List<Object> referenceRows = new ArrayList<>();
        for (Reference reference : refs) {
            Map<String, Object> referenceRow = referenceRow(reference);
            referenceRow.put("target_symbols", symbolsAt(reference.getToAddress()));
            referenceRows.add(referenceRow);
        }
        row.put("references_from", referenceRows);
        return row;
    }

    private List<Object> instructionRange(long startRva, long endRva) {
        List<Object> rows = new ArrayList<>();
        Instruction instruction = currentProgram.getListing().getInstructionAt(at(startRva));
        if (instruction == null) {
            throw new IllegalStateException("range start is not an instruction: " + hex(startRva));
        }
        while (instruction != null && instruction.getAddress().getOffset() <= base + endRva) {
            rows.add(instructionRow(instruction));
            instruction = currentProgram.getListing().getInstructionAfter(instruction.getAddress());
        }
        if (rows.isEmpty()) {
            throw new IllegalStateException("empty instruction range at " + hex(startRva));
        }
        @SuppressWarnings("unchecked")
        Map<String, Object> last = (Map<String, Object>) rows.get(rows.size() - 1);
        if (!hex(endRva).equals(last.get("rva"))) {
            throw new IllegalStateException(
                "range end mismatch: expected " + hex(endRva) + " found " + last.get("rva"));
        }
        return rows;
    }

    private List<Object> instructionSelection(long... rvas) {
        List<Object> rows = new ArrayList<>();
        for (long wanted : rvas) {
            Instruction instruction = currentProgram.getListing().getInstructionAt(at(wanted));
            if (instruction == null) {
                throw new IllegalStateException("missing instruction at RVA " + hex(wanted));
            }
            rows.add(instructionRow(instruction));
        }
        return rows;
    }

    private List<Object> immediateUses(long unsignedValue, int bits) throws Exception {
        List<Object> rows = new ArrayList<>();
        InstructionIterator instructions = currentProgram.getListing().getInstructions(true);
        while (instructions.hasNext()) {
            monitor.checkCancelled();
            Instruction instruction = instructions.next();
            boolean matched = false;
            for (int operand = 0; operand < instruction.getNumOperands() && !matched; operand++) {
                for (Object object : instruction.getOpObjects(operand)) {
                    if (!(object instanceof Scalar)) {
                        continue;
                    }
                    long value = ((Scalar) object).getUnsignedValue();
                    long normalized = bits == 32 ? value & 0xffffffffL : value;
                    if (normalized == unsignedValue) {
                        matched = true;
                        break;
                    }
                }
            }
            if (matched) {
                Map<String, Object> row = new LinkedHashMap<>();
                Function owner = currentProgram.getFunctionManager().getFunctionContaining(
                    instruction.getAddress());
                row.put("instruction", instructionRow(instruction));
                row.put("owner_entry_rva", owner == null ? null : rva(owner.getEntryPoint()));
                row.put("owner_name", owner == null ? null : owner.getName());
                rows.add(row);
            }
        }
        return rows;
    }

    private Map<String, Object> descriptorRow() throws Exception {
        Memory memory = currentProgram.getMemory();
        Address descriptor = at(GROUP_DESCRIPTOR_RVA);
        int groupId = memory.getInt(descriptor);
        int linkedMessageGroupId = memory.getInt(descriptor.add(4));
        int entryCount = memory.getInt(descriptor.add(8));
        int reserved = memory.getInt(descriptor.add(12));
        long entriesVa = memory.getLong(descriptor.add(16));
        if (Integer.toUnsignedLong(groupId) != GROUP_ID || entryCount != 3 ||
            entriesVa != base + GROUP_ENTRIES_RVA) {
            throw new IllegalStateException("group 0x1f43 descriptor layout changed");
        }
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("rva", hex(GROUP_DESCRIPTOR_RVA));
        row.put("group_id", u32hex(groupId));
        row.put("linked_message_group_id", u32hex(linkedMessageGroupId));
        row.put("entry_count", entryCount);
        row.put("reserved_u32", u32hex(reserved));
        row.put("entries_pointer_va", hex(entriesVa));
        row.put("entries_pointer_rva", hex(entriesVa - base));
        List<Object> entries = new ArrayList<>();
        for (int index = 0; index < entryCount; index++) {
            Address entry = toAddr(entriesVa + (long) index * 16L);
            int status = memory.getInt(entry);
            int metadata = memory.getInt(entry.add(4));
            int primaryResource = memory.getInt(entry.add(8));
            int secondaryResource = memory.getInt(entry.add(12));
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("index", index);
            item.put("rva", rva(entry));
            item.put("status_u32", u32hex(status));
            item.put("status_signed", status);
            item.put("metadata_u32", u32hex(metadata));
            item.put("primary_resource_id", u32hex(primaryResource));
            item.put("secondary_resource_id", u32hex(secondaryResource));
            String role = "unknown";
            if (Integer.toUnsignedLong(primaryResource) == 0x1f420003L) {
                role = "newer_version_message";
            } else if (Integer.toUnsignedLong(primaryResource) == 0x1f420004L) {
                role = "invalid_library_message";
            } else if (Integer.toUnsignedLong(primaryResource) == 0x1f420002L) {
                role = "fallback_library_error_member_2";
            }
            item.put("resource_role_from_prior_exact_build_evidence", role);
            entries.add(item);
        }
        row.put("entries", entries);
        return row;
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
            throw new IllegalArgumentException("usage: U01ParserStatusFlow.java <output-json>");
        }
        String actualSha256 = currentProgram.getExecutableSHA256();
        if (actualSha256 == null || !EXPECTED_SHA256.equalsIgnoreCase(actualSha256)) {
            throw new IllegalStateException("unexpected executable SHA-256: " + actualSha256);
        }
        base = currentProgram.getImageBase().getOffset();

        Function parser = requireFunction(PARSER_RVA);
        Function directCaller = requireFunction(DIRECT_CALLER_RVA);
        Function upstreamWrapper = requireFunction(UPSTREAM_WRAPPER_RVA);
        Function alternateParser = requireFunction(ALTERNATE_PARSER_RVA);
        Function statusFormatter = requireFunction(STATUS_FORMATTER_RVA);
        Function descriptorMapper = requireFunction(DESCRIPTOR_MAPPER_RVA);
        Function groupWrapper = requireFunction(GROUP_WRAPPER_RVA);

        long functionCount = 0;
        FunctionIterator functions = currentProgram.getFunctionManager().getFunctions(true);
        while (functions.hasNext()) {
            functions.next();
            functionCount++;
        }

        Map<String, Object> root = new LinkedHashMap<>();
        root.put("schema", "windows-itl.u01-ghidra-parser-status-flow-20260927.v1");
        root.put("classification", "bounded derived static metadata only; no Apple bytes retained");
        Map<String, Object> tool = new LinkedHashMap<>();
        tool.put("name", "Ghidra");
        tool.put("version", Application.getApplicationVersion());
        tool.put("analysis_mode", "saved full headless static analysis; target executable never launched");
        root.put("tool", tool);
        Map<String, Object> executable = new LinkedHashMap<>();
        executable.put("name", currentProgram.getName());
        executable.put("sha256", actualSha256.toLowerCase(Locale.ROOT));
        executable.put("image_base", hex(base));
        executable.put("function_count", functionCount);
        executable.put("binary_retained", false);
        root.put("executable", executable);

        Map<String, Object> functionRows = new LinkedHashMap<>();
        functionRows.put("parser", functionRow(parser));
        functionRows.put("direct_caller", functionRow(directCaller));
        functionRows.put("upstream_wrapper", functionRow(upstreamWrapper));
        functionRows.put("alternate_parser", functionRow(alternateParser));
        functionRows.put("status_formatter", functionRow(statusFormatter));
        functionRows.put("descriptor_mapper", functionRow(descriptorMapper));
        functionRows.put("group_0x1f43_registration_wrapper", functionRow(groupWrapper));
        root.put("functions", functionRows);

        Map<String, Object> windows = new LinkedHashMap<>();
        windows.put("parser_header_word_ceiling",
            instructionRange(0x10ad257L, 0x10ad26aL));
        windows.put("parser_encryption_mode_gate",
            instructionRange(0x10ad2b2L, 0x10ad2c1L));
        windows.put("alternate_parser_encryption_mode_gate",
            instructionRange(0x10f4d42L, 0x10f4d4dL));
        windows.put("direct_caller_parse_return",
            instructionRange(0x53db3aL, 0x53db59L));
        windows.put("direct_caller_status_comparison",
            instructionRange(0x53db8dL, 0x53db94L));
        windows.put("status_error_path_to_group_0x1f43",
            instructionSelection(0x53e30fL, 0x53e316L, 0x53e31cL,
                0x53e387L, 0x53e38cL, 0x53e38fL, 0x53e394L));
        windows.put("upstream_zero_success_gate",
            instructionRange(0x53f622L, 0x53f63eL));
        windows.put("status_formatter_forwarding",
            instructionRange(0xebbfd4L, 0xebbfdfL));
        windows.put("descriptor_dictionary_lookup",
            instructionSelection(0xbfad03L, 0xbfad08L, 0xbfad0bL,
                0xbfad23L, 0xbfad29L, 0xbfad3cL, 0xbfad49L));
        windows.put("descriptor_entry_iteration_and_status_compare",
            instructionRange(0xbfad52L, 0xbfad8dL));
        windows.put("group_0x1f43_registration",
            instructionRange(0x1fb550L, 0x1fb59aL));
        root.put("instruction_windows", windows);

        root.put("group_0x1f43_error_descriptor", descriptorRow());
        root.put("registration_dictionary_global", Map.of(
            "rva", hex(REGISTRATION_DICTIONARY_RVA),
            "symbols", symbolsAt(at(REGISTRATION_DICTIONARY_RVA))));
        root.put("dictionary_get_value_indirect_slot", Map.of(
            "rva", hex(DICTIONARY_GET_VALUE_SLOT_RVA),
            "symbols", symbolsAt(at(DICTIONARY_GET_VALUE_SLOT_RVA))));
        root.put("status_0xfffffc94_immediate_uses", immediateUses(STATUS_U32, 32));
        root.put("group_0x1f43_immediate_uses", immediateUses(GROUP_ID, 64));

        Map<String, Object> feature = new LinkedHashMap<>();
        feature.put("outer_header_byte_offset", "0x41");
        feature.put("single_gate_condition", "unsigned byte >= 3");
        feature.put("values_passing_this_single_native_parser_gate", List.of(0, 1, 2));
        feature.put("status_returned_when_gate_fails", -876);
        feature.put("status_u32", "0xfffffc94");
        feature.put("mapped_primary_resource_id", "0x1f420003");
        feature.put("mapped_resource_role_from_prior_exact_build_evidence",
            "newer_version_message");
        feature.put("version_label_field_used_by_this_gate", false);
        root.put("concrete_non_label_feature_gate", feature);

        Map<String, Object> independentBoundary = new LinkedHashMap<>();
        independentBoundary.put("reference_parser_source", "REFERENCE_PARSER/core.py");
        independentBoundary.put("reference_parser_encryption_byte_offset", "0x41");
        independentBoundary.put("reference_parser_supported_values", List.of(0, 1, 2));
        independentBoundary.put("mode_3_or_greater_passes_independent_preflight", false);
        independentBoundary.put("exact_native_candidate_locked", false);
        independentBoundary.put("native_launch_authorized", false);
        root.put("independent_preflight_boundary", independentBoundary);

        Map<String, Object> conclusion = new LinkedHashMap<>();
        conclusion.put("parser_result_or_status_comparison_identified", true);
        conclusion.put("status_minus_876_producer_identified_in_exact_parser", true);
        conclusion.put("status_minus_876_to_newer_version_resource_mapping_identified", true);
        conclusion.put("concrete_non_version_label_feature_gate_identified", true);
        conclusion.put("exact_product_modal_observed", false);
        conclusion.put("candidate_passes_independent_structural_semantic_preflight", false);
        conclusion.put("native_launch_authorized", false);
        conclusion.put("native_itunes_launches", 0);
        conclusion.put("product_facing_native_negative_established", false);
        conclusion.put("parser_writer_profile_12_12_10_1_supported", false);
        conclusion.put("universal_itl_support", false);
        conclusion.put("independent_semantic_reproduction_passed", false);
        conclusion.put("complete_analysis_gate", false);
        conclusion.put("u01_status", "open");
        root.put("bounded_conclusion", conclusion);

        Path output = Path.of(args[0]);
        Files.createDirectories(output.toAbsolutePath().getParent());
        Files.writeString(output, json(root, 0) + "\n", StandardCharsets.UTF_8);
        println("U01_PARSER_STATUS_FLOW_DONE output=" + output + " sha256=" + actualSha256);
    }
}
