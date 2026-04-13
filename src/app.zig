const std = @import("std");

const FamilyDef = struct {
    id: []const u8,
    label: []const u8,
    group: []const u8,
    summary: []const u8,
    renderer_key: []const u8,
    smoke: bool,
};

const DedicatedMeta = struct {
    focus_key: []const u8,
    focus_value: []const u8,
    source_path: []const u8,
    java_path: []const u8,
    contract_path: []const u8,
};

const ListValuesFamily = struct {
    id: []const u8,
    label: []const u8,
    group: []const u8,
    summary: []const u8,
    rendererKey: []const u8,
    renderer: []const u8,
    smoke: bool,
};

const SessionConfig = struct {
    dev_type: []const u8 = "backend",
    complexity: []const u8 = "medium",
    jargon: []const u8 = "normal",
    output_format: []const u8 = "text",
    seed: []const u8 = "zig-default-seed",
    focus_family: []const u8 = "code_analyzer",
    framework: []const u8 = "",
    project: []const u8 = "stakeholder-circus",
    duration: u32 = 15,
    alerts: bool = false,
    team: bool = false,
    minimal: bool = false,
    trace: bool = false,
    no_color: bool = false,
};

const RunCapture = struct {
    exit_code: u8,
    stdout: []u8,
    stderr: []u8,

    fn deinit(self: *RunCapture, allocator: std.mem.Allocator) void {
        allocator.free(self.stdout);
        allocator.free(self.stderr);
    }
};

const families = [_]FamilyDef{
    .{ .id = "code_analyzer", .label = "code_analyzer", .group = "classic-six", .summary = "code review, build graph, SDK drift", .renderer_key = "classic-six.code_analyzer", .smoke = true },
    .{ .id = "data_processing", .label = "data_processing", .group = "classic-six", .summary = "fixtures, pipelines, transforms", .renderer_key = "classic-six.data_processing", .smoke = true },
    .{ .id = "jargon", .label = "jargon", .group = "classic-six", .summary = "credible domain language", .renderer_key = "classic-six.jargon", .smoke = true },
    .{ .id = "metrics", .label = "metrics", .group = "classic-six", .summary = "token cost, burn, queue depth", .renderer_key = "classic-six.metrics", .smoke = true },
    .{ .id = "network_activity", .label = "network_activity", .group = "classic-six", .summary = "API, SSE, and transport events", .renderer_key = "classic-six.network_activity", .smoke = true },
    .{ .id = "system_monitoring", .label = "system_monitoring", .group = "classic-six", .summary = "health, backpressure, saturation", .renderer_key = "classic-six.system_monitoring", .smoke = true },
    .{ .id = "agent_workflows", .label = "agent_workflows", .group = "modern-core", .summary = "delegation, retries, approvals", .renderer_key = "modern-core.agent_workflows", .smoke = true },
    .{ .id = "platform_engineering", .label = "platform_engineering", .group = "modern-core", .summary = "golden paths, identity, queues", .renderer_key = "modern-core.platform_engineering", .smoke = true },
    .{ .id = "observability_ai_runtime", .label = "observability_ai_runtime", .group = "modern-core", .summary = "tracing, burn rate, GPU pressure", .renderer_key = "modern-core.observability_ai_runtime", .smoke = true },
    .{ .id = "delivery_preview_ops", .label = "delivery_preview_ops", .group = "modern-core", .summary = "preview deploys, canaries, flags", .renderer_key = "modern-core.delivery_preview_ops", .smoke = true },
    .{ .id = "supply_chain_security", .label = "supply_chain_security", .group = "modern-core", .summary = "provenance, attestations, secrets", .renderer_key = "modern-core.supply_chain_security", .smoke = true },
    .{ .id = "ai_inference_ops", .label = "ai_inference_ops", .group = "ai-governance", .summary = "model routing, fallback, cache", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "knowledge_retrieval", .label = "knowledge_retrieval", .group = "ai-governance", .summary = "stale embeddings, recall, citations", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "evaluation_and_guardrails", .label = "evaluation_and_guardrails", .group = "ai-governance", .summary = "eval drift, guardrail failures", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "aibom_provenance", .label = "aibom_provenance", .group = "ai-governance", .summary = "model lineage and AI bills of materials", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "data_governance_compliance", .label = "data_governance_compliance", .group = "ai-governance", .summary = "consent, retention, audit", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "finops_capacity", .label = "finops_capacity", .group = "ai-governance", .summary = "budget, quota, resource burn", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "identity_and_trust", .label = "identity_and_trust", .group = "security-blockchain", .summary = "keys, delegation, trust boundaries", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "agent_boundary_security", .label = "agent_boundary_security", .group = "security-blockchain", .summary = "tool, prompt, and auth boundaries", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "blockchain_protocol_ops", .label = "blockchain_protocol_ops", .group = "security-blockchain", .summary = "rollups, validators, account abstraction", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "cross_chain_interop", .label = "cross_chain_interop", .group = "security-blockchain", .summary = "chain abstraction and transfers", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "proof_and_sequencer_ops", .label = "proof_and_sequencer_ops", .group = "security-blockchain", .summary = "proof queues, ordering, MEV", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "fhir_profile_generator", .label = "fhir_profile_generator", .group = "health-protocol", .summary = "FHIR resource generation", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "smart_launch_oauth", .label = "smart_launch_oauth", .group = "health-protocol", .summary = "SMART launch and OAuth context", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "bulk_fhir_population_ops", .label = "bulk_fhir_population_ops", .group = "health-protocol", .summary = "bulk export and analytics", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "hl7v2_feed_ops", .label = "hl7v2_feed_ops", .group = "health-protocol", .summary = "ADT/ORU feed handling", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "clinical_workflow_events", .label = "clinical_workflow_events", .group = "health-protocol", .summary = "hooks, subscriptions, workflow events", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "dicomweb_imaging_ops", .label = "dicomweb_imaging_ops", .group = "health-protocol", .summary = "QIDO/WADO/STOW imaging flows", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "openehr_semantic_record_ops", .label = "openehr_semantic_record_ops", .group = "health-protocol", .summary = "archetypes, templates, AQL", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "device_telemetry_clinical", .label = "device_telemetry_clinical", .group = "health-protocol", .summary = "bedside telemetry and alerts", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "emr_vendor_adapter", .label = "emr_vendor_adapter", .group = "health-protocol", .summary = "EMR vendor adapter flows", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "ocpp_chargepoint_ops", .label = "ocpp_chargepoint_ops", .group = "health-protocol", .summary = "OCPP 1.6 and 2.x chargepoint ops", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "ocpi_roaming_ops", .label = "ocpi_roaming_ops", .group = "health-protocol", .summary = "roaming, sessions, tariffs", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "mcp_a2a_ops", .label = "mcp_a2a_ops", .group = "health-protocol", .summary = "MCP and A2A tool calls", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "streaming_bus_ops", .label = "streaming_bus_ops", .group = "health-protocol", .summary = "Kafka, NATS, MQTT, event buses", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "service_mesh_rpc_ops", .label = "service_mesh_rpc_ops", .group = "health-protocol", .summary = "gRPC and GraphQL federation", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "edge_client_runtime", .label = "edge_client_runtime", .group = "health-protocol", .summary = "edge UI, hydration, offline sync", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "embedded_agentic_pipeline", .label = "embedded_agentic_pipeline", .group = "health-protocol", .summary = "deterministic control loops", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "multilingual_security_packs", .label = "multilingual_security_packs", .group = "overlay-quantum", .summary = "localized security/operator tone", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "security_persona_packs", .label = "security_persona_packs", .group = "overlay-quantum", .summary = "SOC, CTI, reverse-engineering personas", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "hybrid_runtime_ops", .label = "hybrid_runtime_ops", .group = "overlay-quantum", .summary = "quantum jobs, sessions, batches", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "capacity_cost_controller", .label = "capacity_cost_controller", .group = "overlay-quantum", .summary = "queues, reservations, spend controls", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "batch_execution_tuner", .label = "batch_execution_tuner", .group = "overlay-quantum", .summary = "batch throughput and benchmarks", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "compiler_maintainer", .label = "compiler_maintainer", .group = "overlay-quantum", .summary = "transpiler and plugin maintenance", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "interop_adapter_engineer", .label = "interop_adapter_engineer", .group = "overlay-quantum", .summary = "OpenQASM and QIR adaptation", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "preflight_capacity_planner", .label = "preflight_capacity_planner", .group = "overlay-quantum", .summary = "resource estimation and gating", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "simulator_performance_engineer", .label = "simulator_performance_engineer", .group = "overlay-quantum", .summary = "simulators, GPU, local mode", .renderer_key = "overlay-quantum.fallback", .smoke = false },
};

const dev_types = [_][]const u8{ "backend", "blockchain", "data-science", "dev-ops", "frontend", "fullstack", "game-development", "machine-learning", "security", "systems-programming" };
const jargon_levels = [_][]const u8{ "low", "normal", "high", "extreme" };
const complexities = [_][]const u8{ "low", "medium", "high", "extreme" };
const output_formats = [_][]const u8{ "text", "json" };

pub fn execute(allocator: std.mem.Allocator, stdout: anytype, stderr: anytype, argv: []const []const u8) !u8 {
    if (hasFlag(argv, "--help")) {
        try printHelp(stdout);
        return 0;
    }

    const experimental_flag = findExperimentalFlag(argv);
    if (experimental_flag) |flag| {
        try stderr.print("experimental-provider is not implemented yet in zig-stakeholder ({s})\n", .{flag});
        return 2;
    }

    const config = parseArgs(argv, stderr) catch return 2;

    if (hasFlag(argv, "--list-values")) {
        try writeListValues(allocator, stdout);
        return 0;
    }

    const family = requireFamily(config.focus_family, stderr) catch return 2;
    const session_text = try renderSession(allocator, config, family);
    defer allocator.free(session_text);

    try stdout.writeAll(session_text);
    try stdout.writeByte('\n');
    return 0;
}

fn printHelp(stdout: anytype) !void {
    try stdout.writeAll("Usage: zig-stakeholder [options]\n" ++
        "  --list-values\n" ++
        "  --dev-type <backend|blockchain|data-science|dev-ops|frontend|fullstack|game-development|machine-learning|security|systems-programming>\n" ++
        "  --complexity <low|medium|high|extreme>\n" ++
        "  --jargon <low|normal|high|extreme>\n" ++
        "  --output-format <text|json>\n" ++
        "  --seed <value>\n" ++
        "  --focus-family <family-id>\n" ++
        "  --alerts\n" ++
        "  --team\n" ++
        "  --minimal\n" ++
        "  --trace\n" ++
        "  experimental provider flags are parsed but fail fast\n");
}

fn parseArgs(argv: []const []const u8, stderr: anytype) !SessionConfig {
    var config = SessionConfig{};
    var i: usize = 0;
    while (i < argv.len) : (i += 1) {
        const arg = argv[i];
        if (std.mem.eql(u8, arg, "--list-values") or std.mem.eql(u8, arg, "--help")) {
            continue;
        } else if (std.mem.eql(u8, arg, "--alerts")) {
            config.alerts = true;
        } else if (std.mem.eql(u8, arg, "--team")) {
            config.team = true;
        } else if (std.mem.eql(u8, arg, "--minimal")) {
            config.minimal = true;
        } else if (std.mem.eql(u8, arg, "--trace")) {
            config.trace = true;
        } else if (std.mem.eql(u8, arg, "--no-color")) {
            config.no_color = true;
        } else if (std.mem.eql(u8, arg, "--dev-type")) {
            config.dev_type = try takeValue(argv, &i, stderr, arg);
            if (!containsString(dev_types[0..], config.dev_type)) return invalidValue(stderr, "--dev-type", config.dev_type);
        } else if (std.mem.eql(u8, arg, "--complexity")) {
            config.complexity = try takeValue(argv, &i, stderr, arg);
            if (!containsString(complexities[0..], config.complexity)) return invalidValue(stderr, "--complexity", config.complexity);
        } else if (std.mem.eql(u8, arg, "--jargon")) {
            config.jargon = try takeValue(argv, &i, stderr, arg);
            if (!containsString(jargon_levels[0..], config.jargon)) return invalidValue(stderr, "--jargon", config.jargon);
        } else if (std.mem.eql(u8, arg, "--output-format")) {
            config.output_format = try takeValue(argv, &i, stderr, arg);
            if (!containsString(output_formats[0..], config.output_format)) return invalidValue(stderr, "--output-format", config.output_format);
        } else if (std.mem.eql(u8, arg, "--seed")) {
            config.seed = try takeValue(argv, &i, stderr, arg);
        } else if (std.mem.eql(u8, arg, "--focus-family")) {
            config.focus_family = try takeValue(argv, &i, stderr, arg);
        } else if (std.mem.eql(u8, arg, "--framework")) {
            config.framework = try takeValue(argv, &i, stderr, arg);
        } else if (std.mem.eql(u8, arg, "--project")) {
            config.project = try takeValue(argv, &i, stderr, arg);
        } else if (std.mem.eql(u8, arg, "--duration")) {
            const raw = try takeValue(argv, &i, stderr, arg);
            config.duration = std.fmt.parseInt(u32, raw, 10) catch {
                try stderr.print("Invalid value '{s}' for --duration.\n", .{raw});
                return error.InvalidValue;
            };
        } else if (std.mem.eql(u8, arg, "--experimental-provider")) {
            _ = try takeValue(argv, &i, stderr, arg);
            try stderr.writeAll("experimental-provider is not implemented yet in zig-stakeholder (--experimental-provider)\n");
            return error.ExperimentalProvider;
        } else if (std.mem.startsWith(u8, arg, "--experimental-provider")) {
            try stderr.print("experimental-provider is not implemented yet in zig-stakeholder ({s})\n", .{arg});
            return error.ExperimentalProvider;
        } else {
            try stderr.print("Unknown argument '{s}'.\n", .{arg});
            return error.InvalidValue;
        }
    }
    return config;
}

fn renderSession(allocator: std.mem.Allocator, config: SessionConfig, family: FamilyDef) ![]u8 {
    if (std.mem.eql(u8, config.output_format, "json")) {
        return renderSessionJson(allocator, config, family);
    }
    return renderSessionText(allocator, config, family);
}

fn renderSessionJson(allocator: std.mem.Allocator, config: SessionConfig, family: FamilyDef) ![]u8 {
    const meta = dedicatedMeta(family.id);
    const renderer = family.renderer_key;
    const detail = if (family.smoke) "dedicated first-push renderer" else "grouped fallback renderer";
    const timestamp = try deterministicTimestamp(allocator, config.seed, family.id);
    defer allocator.free(timestamp);
    const session_id = try deterministicSessionId(allocator, config.seed, family.id);
    defer allocator.free(session_id);
    const message = try sessionMessage(allocator, family, meta, detail);
    defer allocator.free(message);

    const event = .{
        .eventType = "generator.activity",
        .sequence = @as(u32, 1),
        .message = message,
        .timestamp = timestamp,
        .context = .{
            .family = family.id,
            .renderer = renderer,
            .detail = detail,
            .familyFocusKey = meta.focus_key,
            .analysisFocus = if (std.mem.eql(u8, meta.focus_key, "analysisFocus")) meta.focus_value else null,
            .dataWindow = if (std.mem.eql(u8, meta.focus_key, "dataWindow")) meta.focus_value else null,
            .languagePolicy = if (std.mem.eql(u8, meta.focus_key, "languagePolicy")) meta.focus_value else null,
            .signalBlend = if (std.mem.eql(u8, meta.focus_key, "signalBlend")) meta.focus_value else null,
            .transportMix = if (std.mem.eql(u8, meta.focus_key, "transportMix")) meta.focus_value else null,
            .telemetryScope = if (std.mem.eql(u8, meta.focus_key, "telemetryScope")) meta.focus_value else null,
            .coordinationMode = if (std.mem.eql(u8, meta.focus_key, "coordinationMode")) meta.focus_value else null,
            .platformSurface = if (std.mem.eql(u8, meta.focus_key, "platformSurface")) meta.focus_value else null,
            .runtimeSignals = if (std.mem.eql(u8, meta.focus_key, "runtimeSignals")) meta.focus_value else null,
            .deliveryGuardrail = if (std.mem.eql(u8, meta.focus_key, "deliveryGuardrail")) meta.focus_value else null,
            .supplyChainPosture = if (std.mem.eql(u8, meta.focus_key, "supplyChainPosture")) meta.focus_value else null,
            .traceabilitySourceRepo = "rust-stakeholder",
            .traceabilityJavaRepo = "java-stakeholder",
            .traceabilityContractRepo = "stakeholder-core",
            .traceabilityParityClass = "full-parity",
            .traceabilitySourcePath = meta.source_path,
            .traceabilityJavaPath = meta.java_path,
            .traceabilityContractPath = meta.contract_path,
        },
    };

    const payload = .{
        .sessionId = session_id,
        .mode = "deterministic",
        .config = .{
            .devType = config.dev_type,
            .complexity = config.complexity,
            .jargon = config.jargon,
            .outputFormat = config.output_format,
            .seed = config.seed,
            .focusFamily = family.id,
            .framework = config.framework,
            .project = config.project,
            .duration = config.duration,
            .alerts = config.alerts,
            .team = config.team,
            .minimal = config.minimal,
            .trace = config.trace,
            .noColor = config.no_color,
        },
        .events = [_]@TypeOf(event){event},
    };

    return try std.json.Stringify.valueAlloc(allocator, payload, .{});
}

fn renderSessionText(allocator: std.mem.Allocator, config: SessionConfig, family: FamilyDef) ![]u8 {
    const meta = dedicatedMeta(family.id);
    const session_id = try deterministicSessionId(allocator, config.seed, family.id);
    defer allocator.free(session_id);
    const message = try sessionMessage(allocator, family, meta, if (family.smoke) "dedicated first-push renderer" else "grouped fallback renderer");
    defer allocator.free(message);
    return std.fmt.allocPrint(allocator, "{s} deterministic {s}\n{s}", .{ session_id, config.dev_type, message });
}

fn writeListValues(allocator: std.mem.Allocator, stdout: anytype) !void {
    const families_out = comptime buildListValuesFamilies();
    const payload = .{
        .generatorFamilies = families_out,
        .devTypes = dev_types,
        .jargonLevels = jargon_levels,
        .complexities = complexities,
        .outputFormats = output_formats,
    };
    const json_text = try std.json.Stringify.valueAlloc(allocator, payload, .{});
    defer allocator.free(json_text);
    try stdout.writeAll(json_text);
}

fn buildListValuesFamilies() [families.len]ListValuesFamily {
    var out: [families.len]ListValuesFamily = undefined;
    for (families, 0..) |family, idx| {
        out[idx] = .{
            .id = family.id,
            .label = family.label,
            .group = family.group,
            .summary = family.summary,
            .rendererKey = family.renderer_key,
            .renderer = family.renderer_key,
            .smoke = family.smoke,
        };
    }
    return out;
}

fn dedicatedMeta(family_id: []const u8) DedicatedMeta {
    if (std.mem.eql(u8, family_id, "code_analyzer")) return .{ .focus_key = "analysisFocus", .focus_value = "typed interfaces, agent-authored patches, and MCP assumptions", .source_path = "src/generators/code_analyzer.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/CodeAnalyzerRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#code_analyzer" };
    if (std.mem.eql(u8, family_id, "data_processing")) return .{ .focus_key = "dataWindow", .focus_value = "embeddings, semantic chunks, and batch transforms with deterministic ordering", .source_path = "src/generators/data_processing.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/DataProcessingRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#data_processing" };
    if (std.mem.eql(u8, family_id, "jargon")) return .{ .focus_key = "languagePolicy", .focus_value = "credible 2026 terminology instead of fake-deep phrasing", .source_path = "src/generators/jargon.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/JargonRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#jargon" };
    if (std.mem.eql(u8, family_id, "metrics")) return .{ .focus_key = "signalBlend", .focus_value = "queue depth, token spend, and GPU occupancy in a single operations lane", .source_path = "src/generators/metrics.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/MetricsRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#metrics" };
    if (std.mem.eql(u8, family_id, "network_activity")) return .{ .focus_key = "transportMix", .focus_value = "RPC, event-stream, and adapter traffic under deterministic retry rules", .source_path = "src/generators/network_activity.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/NetworkActivityRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#network_activity" };
    if (std.mem.eql(u8, family_id, "system_monitoring")) return .{ .focus_key = "telemetryScope", .focus_value = "collector pressure, runner health, and policy-denial signals across the stack", .source_path = "src/generators/system_monitoring.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/SystemMonitoringRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#system_monitoring" };
    if (std.mem.eql(u8, family_id, "agent_workflows")) return .{ .focus_key = "coordinationMode", .focus_value = "delegated agent work, approval gates, and cross-repo handoff envelopes", .source_path = "src/generators/agent_workflows.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/AgentWorkflowsRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#agent_workflows" };
    if (std.mem.eql(u8, family_id, "platform_engineering")) return .{ .focus_key = "platformSurface", .focus_value = "golden paths, identity boundaries, and queue ownership in the shared platform lane", .source_path = "src/generators/platform_engineering.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/PlatformEngineeringRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#platform_engineering" };
    if (std.mem.eql(u8, family_id, "observability_ai_runtime")) return .{ .focus_key = "runtimeSignals", .focus_value = "trace spans, token burn, GPU pressure, and policy denials in one runtime lane", .source_path = "src/generators/observability_ai_runtime.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/ObservabilityAiRuntimeRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#observability_ai_runtime" };
    if (std.mem.eql(u8, family_id, "delivery_preview_ops")) return .{ .focus_key = "deliveryGuardrail", .focus_value = "preview deploys, canaries, release flags, and rollback checkpoints under seed control", .source_path = "src/generators/delivery_preview_ops.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/DeliveryPreviewOpsRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#delivery_preview_ops" };
    if (std.mem.eql(u8, family_id, "supply_chain_security")) return .{ .focus_key = "supplyChainPosture", .focus_value = "provenance, attestations, dependency drift, and secret exposure in one security lane", .source_path = "src/generators/supply_chain_security.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/SupplyChainSecurityRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#supply_chain_security" };
    return .{ .focus_key = "groupFallback", .focus_value = "later packet families remain grouped until their dedicated tranche lands", .source_path = "src/activities.rs", .java_path = "java-stakeholder/src/main/java/stakeholder/generators/GroupedFallbackRenderer.java", .contract_path = "stakeholder-core/docs/traceability-matrix.md#grouped-fallback" };
}

fn sessionMessage(allocator: std.mem.Allocator, family: FamilyDef, meta: DedicatedMeta, detail: []const u8) ![]u8 {
    return std.fmt.allocPrint(allocator, "{s}: {s}; {s} aligned to Java, Rust, and stakeholder-core with explicit allocator control.", .{ family.id, meta.focus_value, detail });
}

fn deterministicHash(seed: []const u8, family: []const u8) u64 {
    var hasher = std.hash.Fnv1a_64.init();
    hasher.update(seed);
    hasher.update("::");
    hasher.update(family);
    return hasher.final();
}

fn deterministicTimestamp(allocator: std.mem.Allocator, seed: []const u8, family: []const u8) ![]u8 {
    const seconds = @mod(deterministicHash(seed, family), 60);
    return std.fmt.allocPrint(allocator, "2026-01-01T00:00:{d:0>2}Z", .{seconds});
}

fn deterministicSessionId(allocator: std.mem.Allocator, seed: []const u8, family: []const u8) ![]u8 {
    return std.fmt.allocPrint(allocator, "zig-{x}", .{deterministicHash(seed, family)});
}

fn hasFlag(argv: []const []const u8, flag: []const u8) bool {
    for (argv) |arg| if (std.mem.eql(u8, arg, flag)) return true;
    return false;
}

fn findExperimentalFlag(argv: []const []const u8) ?[]const u8 {
    for (argv) |arg| {
        if (std.mem.startsWith(u8, arg, "--experimental-provider")) return arg;
    }
    return null;
}

fn containsString(haystack: []const []const u8, needle: []const u8) bool {
    for (haystack) |item| if (std.mem.eql(u8, item, needle)) return true;
    return false;
}

fn takeValue(argv: []const []const u8, i: *usize, stderr: anytype, flag: []const u8) ![]const u8 {
    if (i.* + 1 >= argv.len) {
        try stderr.print("Missing value for {s}.\n", .{flag});
        return error.MissingValue;
    }
    i.* += 1;
    return argv[i.*];
}

fn invalidValue(stderr: anytype, flag: []const u8, value: []const u8) !SessionConfig {
    try stderr.print("Invalid value '{s}' for {s}.\n", .{ value, flag });
    return error.InvalidValue;
}

fn requireFamily(family_id: []const u8, stderr: anytype) !FamilyDef {
    for (families) |family| {
        if (std.ascii.eqlIgnoreCase(family.id, family_id)) return family;
    }
    try stderr.print("Unknown family '{s}'.\n", .{family_id});
    return error.UnknownFamily;
}

fn runCapture(allocator: std.mem.Allocator, args: []const []const u8) !RunCapture {
    var stdout_buf = try std.ArrayList(u8).initCapacity(allocator, 0);
    errdefer stdout_buf.deinit(allocator);
    var stderr_buf = try std.ArrayList(u8).initCapacity(allocator, 0);
    errdefer stderr_buf.deinit(allocator);
    const exit_code = try execute(allocator, stdout_buf.writer(allocator), stderr_buf.writer(allocator), args);
    return .{
        .exit_code = exit_code,
        .stdout = try stdout_buf.toOwnedSlice(allocator),
        .stderr = try stderr_buf.toOwnedSlice(allocator),
    };
}

test "list-values exposes the full registry and dedicated renderer keys" {
    var capture = try runCapture(std.testing.allocator, &.{"--list-values"});
    defer capture.deinit(std.testing.allocator);

    var parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, capture.stdout, .{});
    defer parsed.deinit();

    const families_value = parsed.value.object.get("generatorFamilies").?;
    try std.testing.expect(families_value.array.items.len >= 30);

    const required = [_][2][]const u8{
        .{ "code_analyzer", "classic-six.code_analyzer" },
        .{ "data_processing", "classic-six.data_processing" },
        .{ "jargon", "classic-six.jargon" },
        .{ "metrics", "classic-six.metrics" },
        .{ "network_activity", "classic-six.network_activity" },
        .{ "system_monitoring", "classic-six.system_monitoring" },
        .{ "agent_workflows", "modern-core.agent_workflows" },
        .{ "platform_engineering", "modern-core.platform_engineering" },
        .{ "observability_ai_runtime", "modern-core.observability_ai_runtime" },
        .{ "delivery_preview_ops", "modern-core.delivery_preview_ops" },
        .{ "supply_chain_security", "modern-core.supply_chain_security" },
    };

    for (required) |entry| {
        var found = false;
        for (families_value.array.items) |family| {
            if (std.mem.eql(u8, family.object.get("id").?.string, entry[0])) {
                found = true;
                try std.testing.expectEqualStrings(entry[1], family.object.get("rendererKey").?.string);
                try std.testing.expectEqual(true, family.object.get("smoke").?.bool);
            }
        }
        try std.testing.expect(found);
    }
}

test "dedicated families emit expected metadata" {
    const cases = [_]struct {
        family_id: []const u8,
        renderer_key: []const u8,
        focus_key: []const u8,
        focus_value: []const u8,
    }{
        .{ .family_id = "code_analyzer", .renderer_key = "classic-six.code_analyzer", .focus_key = "analysisFocus", .focus_value = "typed interfaces, agent-authored patches, and MCP assumptions" },
        .{ .family_id = "data_processing", .renderer_key = "classic-six.data_processing", .focus_key = "dataWindow", .focus_value = "embeddings, semantic chunks, and batch transforms with deterministic ordering" },
        .{ .family_id = "jargon", .renderer_key = "classic-six.jargon", .focus_key = "languagePolicy", .focus_value = "credible 2026 terminology instead of fake-deep phrasing" },
        .{ .family_id = "metrics", .renderer_key = "classic-six.metrics", .focus_key = "signalBlend", .focus_value = "queue depth, token spend, and GPU occupancy in a single operations lane" },
        .{ .family_id = "network_activity", .renderer_key = "classic-six.network_activity", .focus_key = "transportMix", .focus_value = "RPC, event-stream, and adapter traffic under deterministic retry rules" },
        .{ .family_id = "system_monitoring", .renderer_key = "classic-six.system_monitoring", .focus_key = "telemetryScope", .focus_value = "collector pressure, runner health, and policy-denial signals across the stack" },
        .{ .family_id = "agent_workflows", .renderer_key = "modern-core.agent_workflows", .focus_key = "coordinationMode", .focus_value = "delegated agent work, approval gates, and cross-repo handoff envelopes" },
        .{ .family_id = "platform_engineering", .renderer_key = "modern-core.platform_engineering", .focus_key = "platformSurface", .focus_value = "golden paths, identity boundaries, and queue ownership in the shared platform lane" },
        .{ .family_id = "observability_ai_runtime", .renderer_key = "modern-core.observability_ai_runtime", .focus_key = "runtimeSignals", .focus_value = "trace spans, token burn, GPU pressure, and policy denials in one runtime lane" },
        .{ .family_id = "delivery_preview_ops", .renderer_key = "modern-core.delivery_preview_ops", .focus_key = "deliveryGuardrail", .focus_value = "preview deploys, canaries, release flags, and rollback checkpoints under seed control" },
        .{ .family_id = "supply_chain_security", .renderer_key = "modern-core.supply_chain_security", .focus_key = "supplyChainPosture", .focus_value = "provenance, attestations, dependency drift, and secret exposure in one security lane" },
    };

    for (cases) |case| {
        var capture = try runCapture(std.testing.allocator, &.{ "--dev-type", "backend", "--complexity", "medium", "--seed", "zig-dedicated-seed", "--focus-family", case.family_id, "--output-format", "json" });
        defer capture.deinit(std.testing.allocator);

        var parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, capture.stdout, .{});
        defer parsed.deinit();

        const events = parsed.value.object.get("events").?.array.items;
        const activity = events[0];
        try std.testing.expectEqualStrings("generator.activity", activity.object.get("eventType").?.string);
        try std.testing.expectEqualStrings(case.renderer_key, activity.object.get("context").?.object.get("renderer").?.string);
        try std.testing.expectEqualStrings("dedicated first-push renderer", activity.object.get("context").?.object.get("detail").?.string);
        try std.testing.expectEqualStrings(case.focus_key, activity.object.get("context").?.object.get("familyFocusKey").?.string);
        try std.testing.expectEqualStrings(case.focus_value, activity.object.get("context").?.object.get(case.focus_key).?.string);
        try std.testing.expectEqualStrings("rust-stakeholder", activity.object.get("context").?.object.get("traceabilitySourceRepo").?.string);
        try std.testing.expectEqualStrings("java-stakeholder", activity.object.get("context").?.object.get("traceabilityJavaRepo").?.string);
        try std.testing.expectEqualStrings("stakeholder-core", activity.object.get("context").?.object.get("traceabilityContractRepo").?.string);
        try std.testing.expectEqualStrings("full-parity", activity.object.get("context").?.object.get("traceabilityParityClass").?.string);
        try std.testing.expect(std.mem.indexOf(u8, activity.object.get("message").?.string, "Java, Rust, and stakeholder-core") != null);
    }
}

test "deterministic json stays stable for the same seed" {
    var first = try runCapture(std.testing.allocator, &.{ "--dev-type", "backend", "--complexity", "medium", "--seed", "zig-first-push-stability", "--focus-family", "code_analyzer", "--output-format", "json" });
    defer first.deinit(std.testing.allocator);
    var second = try runCapture(std.testing.allocator, &.{ "--dev-type", "backend", "--complexity", "medium", "--seed", "zig-first-push-stability", "--focus-family", "code_analyzer", "--output-format", "json" });
    defer second.deinit(std.testing.allocator);
    try std.testing.expectEqualStrings(first.stdout, second.stdout);
}

test "experimental provider flags fail fast" {
    var capture = try runCapture(std.testing.allocator, &.{ "--experimental-provider", "openai-compatible" });
    defer capture.deinit(std.testing.allocator);
    try std.testing.expectEqual(@as(u8, 2), capture.exit_code);
    try std.testing.expect(std.mem.indexOf(u8, capture.stderr, "experimental-provider is not implemented yet in zig-stakeholder") != null);
}
