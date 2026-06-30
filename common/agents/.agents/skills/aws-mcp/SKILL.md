---
name: aws-mcp
description: AWS operations via mcporter CLI tool. Provides access to AWS documentation search, pricing data, CloudFormation/CDK IaC validation, and general AWS API via configured MCP servers. Invoke using `mcporter list <server> --schema` and `mcporter call <server>.<tool> arg:value`.
---

# AWS MCP via mcporter

You have `mcporter` installed with these MCP servers providing AWS capabilities:

| Server | Purpose |
|--------|---------|
| `awslabs_aws-documentation-mcp-server` | Search, read, and extract AWS documentation |
| `awslabs_aws-pricing-mcp-server` | AWS service pricing data and cost analysis |
| `awslabs_aws-iac-mcp-server` | CloudFormation, CDK validation and IaC support |
| `aws-mcp` | General AWS API proxy (⚠️ connection issue) |

## Workflow

1. **Discover tools** on a server:
   ```bash
   mcporter list <server> --schema
   ```

2. **Call a tool**:
   ```bash
   mcporter call <server>.<tool> arg1:value1 arg2:value2
   ```
   Or use function-call syntax:
   ```bash
   mcporter call '<server>.<tool>(arg1: "value1", arg2: "value2")'
   ```

3. **Pass JSON/complex args** — works naturally with the function-call syntax.

## Server Details

### awslabs_aws-documentation-mcp-server
Tools: `search_documentation`, `read_documentation`, `read_sections`, `recommend`
```bash
mcporter list awslabs_aws-documentation-mcp-server --schema
mcporter call awslabs_aws-documentation-mcp-server.search_documentation search_phrase:"S3 bucket naming"
mcporter call awslabs_aws-documentation-mcp-server.read_documentation url:"https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
```

### awslabs_aws-pricing-mcp-server
Tools: `get_pricing`, `get_pricing_service_codes`, `get_pricing_service_attributes`, `get_pricing_attribute_values`, `get_price_list_urls`, `generate_cost_report`, `analyze_cdk_project`, `analyze_terraform_project`, `get_bedrock_patterns`
```bash
mcporter list awslabs_aws-pricing-mcp-server --schema
mcporter call awslabs_aws-pricing-mcp-server.get_pricing_service_codes
mcporter call awslabs_aws-pricing-mcp-server.get_pricing service_code:AmazonEC2 region:ap-south-1
```

### awslabs_aws-iac-mcp-server
Tools: `validate_cloudformation_template`, `check_cloudformation_template_compliance`, `troubleshoot_cloudformation_deployment`, `search_cdk_documentation`, `search_cloudformation_documentation`, `search_cdk_samples_and_constructs`, `cdk_best_practices`, `read_iac_documentation_page`, `get_cloudformation_pre_deploy_validation_instructions`
```bash
mcporter list awslabs_aws-iac-mcp-server --schema
mcporter call awslabs_aws-iac-mcp-server.validate_cloudformation_template template_content:"$(cat template.yaml)"
```

### aws-mcp
General AWS API proxy. Likely needs AWS credentials configuration.
```bash
mcporter list aws-mcp --schema
```

## Tips

- Use `--json` flag on `mcporter list` or `mcporter call` for machine-readable JSON output
- Always run `mcporter list <server> --schema` first to discover available tools and their parameters
- For multi-region pricing queries, pass region as a list: `region:["us-east-1","eu-west-1"]`
- When calling tools with complex JSON args, use the function-call syntax with proper quoting
