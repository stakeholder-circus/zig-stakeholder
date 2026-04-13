const std = @import("std");

pub const FamilyGroup = enum {
    classic_six,
    modern_core,
    ai_governance,
    security_blockchain,
    health_protocol,
    overlay_quantum,

    pub fn label(self: FamilyGroup) []const u8 {
        return switch (self) {
            .classic_six => "classic_six",
            .modern_core => "modern_core",
            .ai_governance => "ai_governance",
            .security_blockchain => "security_blockchain",
            .health_protocol => "health_protocol",
            .overlay_quantum => "overlay_quantum",
        };
    }
};

pub const Family = struct {
    id: []const u8,
    label: []const u8,
    group: FamilyGroup,
    summary: []const u8,
    renderer_key: []const u8,
    smoke: bool,
};

pub const dev_types = [_][]const u8{
    "backend",
    "blockchain",
    "data-science",
    "dev-ops",
    "frontend",
    "fullstack",
    "game-development",
    "machine-learning",
    "security",
    "systems-programming",
};

pub const jargon_levels = [_][]const u8{ "low", "normal", "high", "extreme" };
pub const complexities = [_][]const u8{ "low", "medium", "high", "extreme" };
pub const output_formats = [_][]const u8{ "text", "json" };

pub const all_families = [_]Family{
    .{ .id = "code_analyzer", .label = "code_analyzer", .group = .classic_six, .summary = "code review, build graph, SDK drift", .renderer_key = "classic-six.code_analyzer", .smoke = true },
    .{ .id = "data_processing", .label = "data_processing", .group = .classic_six, .summary = "fixtures, pipelines, transforms", .renderer_key = "classic-six.data_processing", .smoke = true },
    .{ .id = "jargon", .label = "jargon", .group = .classic_six, .summary = "credible domain language", .renderer_key = "classic-six.jargon", .smoke = true },
    .{ .id = "metrics", .label = "metrics", .group = .classic_six, .summary = "token cost, burn, queue depth", .renderer_key = "classic-six.metrics", .smoke = true },
    .{ .id = "network_activity", .label = "network_activity", .group = .classic_six, .summary = "API, SSE, and transport events", .renderer_key = "classic-six.network_activity", .smoke = true },
    .{ .id = "system_monitoring", .label = "system_monitoring", .group = .classic_six, .summary = "health, backpressure, saturation", .renderer_key = "classic-six.system_monitoring", .smoke = true },
    .{ .id = "agent_workflows", .label = "agent_workflows", .group = .modern_core, .summary = "delegation, retries, approvals", .renderer_key = "modern-core.agent_workflows", .smoke = true },
    .{ .id = "platform_engineering", .label = "platform_engineering", .group = .modern_core, .summary = "golden paths, identity, queues", .renderer_key = "modern-core.platform_engineering", .smoke = true },
    .{ .id = "observability_ai_runtime", .label = "observability_ai_runtime", .group = .modern_core, .summary = "tracing, burn rate, GPU pressure", .renderer_key = "modern-core.observability_ai_runtime", .smoke = true },
    .{ .id = "delivery_preview_ops", .label = "delivery_preview_ops", .group = .modern_core, .summary = "preview deploys, canaries, flags", .renderer_key = "modern-core.delivery_preview_ops", .smoke = true },
    .{ .id = "supply_chain_security", .label = "supply_chain_security", .group = .modern_core, .summary = "provenance, attestations, secrets", .renderer_key = "modern-core.supply_chain_security", .smoke = true },
    .{ .id = "ai_inference_ops", .label = "ai_inference_ops", .group = .ai_governance, .summary = "model routing, fallback, cache", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "knowledge_retrieval", .label = "knowledge_retrieval", .group = .ai_governance, .summary = "stale embeddings, recall, citations", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "evaluation_and_guardrails", .label = "evaluation_and_guardrails", .group = .ai_governance, .summary = "eval drift, guardrail failures", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "aibom_provenance", .label = "aibom_provenance", .group = .ai_governance, .summary = "model lineage and AI bills of materials", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "data_governance_compliance", .label = "data_governance_compliance", .group = .ai_governance, .summary = "consent, retention, audit", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "finops_capacity", .label = "finops_capacity", .group = .ai_governance, .summary = "budget, quota, resource burn", .renderer_key = "ai-governance.fallback", .smoke = false },
    .{ .id = "identity_and_trust", .label = "identity_and_trust", .group = .security_blockchain, .summary = "keys, delegation, trust boundaries", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "agent_boundary_security", .label = "agent_boundary_security", .group = .security_blockchain, .summary = "tool, prompt, and auth boundaries", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "blockchain_protocol_ops", .label = "blockchain_protocol_ops", .group = .security_blockchain, .summary = "rollups, validators, account abstraction", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "cross_chain_interop", .label = "cross_chain_interop", .group = .security_blockchain, .summary = "chain abstraction and transfers", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "proof_and_sequencer_ops", .label = "proof_and_sequencer_ops", .group = .security_blockchain, .summary = "proof queues, ordering, MEV", .renderer_key = "security-blockchain.fallback", .smoke = false },
    .{ .id = "fhir_profile_generator", .label = "fhir_profile_generator", .group = .health_protocol, .summary = "FHIR resource generation", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "smart_launch_oauth", .label = "smart_launch_oauth", .group = .health_protocol, .summary = "SMART launch and OAuth context", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "bulk_fhir_population_ops", .label = "bulk_fhir_population_ops", .group = .health_protocol, .summary = "bulk export and analytics", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "hl7v2_feed_ops", .label = "hl7v2_feed_ops", .group = .health_protocol, .summary = "ADT/ORU feed handling", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "clinical_workflow_events", .label = "clinical_workflow_events", .group = .health_protocol, .summary = "hooks, subscriptions, workflow events", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "dicomweb_imaging_ops", .label = "dicomweb_imaging_ops", .group = .health_protocol, .summary = "QIDO/WADO/STOW imaging flows", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "openehr_semantic_record_ops", .label = "openehr_semantic_record_ops", .group = .health_protocol, .summary = "archetypes, templates, AQL", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "device_telemetry_clinical", .label = "device_telemetry_clinical", .group = .health_protocol, .summary = "bedside telemetry and alerts", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "emr_vendor_adapter", .label = "emr_vendor_adapter", .group = .health_protocol, .summary = "EMR vendor adapter flows", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "ocpp_chargepoint_ops", .label = "ocpp_chargepoint_ops", .group = .health_protocol, .summary = "OCPP 1.6 and 2.x chargepoint ops", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "ocpi_roaming_ops", .label = "ocpi_roaming_ops", .group = .health_protocol, .summary = "roaming, sessions, tariffs", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "mcp_a2a_ops", .label = "mcp_a2a_ops", .group = .health_protocol, .summary = "MCP and A2A tool calls", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "streaming_bus_ops", .label = "streaming_bus_ops", .group = .health_protocol, .summary = "Kafka, NATS, MQTT, event buses", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "service_mesh_rpc_ops", .label = "service_mesh_rpc_ops", .group = .health_protocol, .summary = "gRPC and GraphQL federation", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "edge_client_runtime", .label = "edge_client_runtime", .group = .health_protocol, .summary = "edge UI, hydration, offline sync", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "embedded_agentic_pipeline", .label = "embedded_agentic_pipeline", .group = .health_protocol, .summary = "deterministic control loops", .renderer_key = "health-protocol.fallback", .smoke = false },
    .{ .id = "multilingual_security_packs", .label = "multilingual_security_packs", .group = .overlay_quantum, .summary = "localized security/operator tone", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "security_persona_packs", .label = "security_persona_packs", .group = .overlay_quantum, .summary = "SOC, CTI, reverse-engineering personas", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "hybrid_runtime_ops", .label = "hybrid_runtime_ops", .group = .overlay_quantum, .summary = "quantum jobs, sessions, batches", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "capacity_cost_controller", .label = "capacity_cost_controller", .group = .overlay_quantum, .summary = "queues, reservations, spend controls", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "batch_execution_tuner", .label = "batch_execution_tuner", .group = .overlay_quantum, .summary = "batch throughput and benchmarks", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "compiler_maintainer", .label = "compiler_maintainer", .group = .overlay_quantum, .summary = "transpiler and plugin maintenance", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "interop_adapter_engineer", .label = "interop_adapter_engineer", .group = .overlay_quantum, .summary = "OpenQASM and QIR adaptation", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "preflight_capacity_planner", .label = "preflight_capacity_planner", .group = .overlay_quantum, .summary = "resource estimation and gating", .renderer_key = "overlay-quantum.fallback", .smoke = false },
    .{ .id = "simulator_performance_engineer", .label = "simulator_performance_engineer", .group = .overlay_quantum, .summary = "simulators, GPU, local mode", .renderer_key = "overlay-quantum.fallback", .smoke = false },
};

pub fn findFamily(id: []const u8) ?Family {
    for (all_families) |family| {
        if (std.ascii.eqlIgnoreCase(family.id, id)) return family;
    }
    return null;
}
