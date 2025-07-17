# AI-Powered Oracle Development with SQLcl MCP

Transform your Oracle database development workflow by using natural language to generate SQL queries, perform analytics, and explore databases through AI assistance.

## 🚀 What This Demo Does

Instead of writing SQL from scratch, you can:
- Say **"Show me employees hired last month"** → Get instant Oracle SQL results
- Ask **"Which departments have the highest average salary?"** → Get analytics with rankings
- Request **"Create a comprehensive HR dashboard"** → Get multiple analytical queries

This repository demonstrates how to set up an AI assistant that understands Oracle databases and generates sophisticated SQL from plain English.

## 🏗️ Architecture

```
Your English → AI Model (NLP) → SQLcl MCP Server → Oracle Database
     ↑                                                    ↓
Human readable results ← AI Model (formats) ← Raw SQL results
```

### Key Components

- **🧠 AI Model (Claude/GPT)**: Processes natural language and generates Oracle SQL
- **🔌 SQLcl MCP Server**: Secure bridge between AI and Oracle database  
- **📊 Oracle Database**: Executes queries and returns data
- **🔧 VS Code Extensions**: Visual database management + AI assistant interface

## 📋 Prerequisites

- **Oracle Database** (Docker, Autonomous Database, or local installation)
- **Oracle SQLcl 25.2.0+** with MCP support
- **Java Runtime Environment 17+**
- **Visual Studio Code**
- **AI API access** (Claude, OpenAI, etc.)

## 🎯 Quick Start

### 1. Start Oracle Database

```bash
# Option A: Docker (Recommended for demo)
docker run --name oracle-demo -d -p 1521:1521 \
  -e ORACLE_PASSWORD=Welcome12345 \
  -e APP_USER=hr \
  -e APP_USER_PASSWORD=Welcome12345 \
  gvenzl/oracle-free:23.7-slim-faststart
```

### 2. Set Up Project

```bash
git clone <this-repo>
cd ai-oracle-sqlcl-demo
code .
```

### 3. Install VS Code Extensions

- **Oracle SQL Developer** - Database management
- **Cline** - AI assistant

### 4. Create Sample Data

```sql
-- Run the setup script
@sql/setup/create_hr_schema.sql
@sql/setup/load_sample_data.sql
```

### 5. Configure MCP Connection

```bash
# Create saved connection for MCP
sql hr/Welcome12345@localhost:1521/FREEPDB1
conn -save hr_demo -savepwd
exit
```

### 6. Start AI-Database Bridge

```bash
sql -mcp
```

### 7. Configure Cline

Add to `cline_mcp_settings.json`:
```json
{
  "mcpServers": {
    "SQLcl": {
      "command": "sql",
      "args": ["-mcp"],
      "disabled": false
    }
  }
}
```

### 8. Try Natural Language Queries

In Cline, try:
```
"Connect to hr_demo and show me all employees hired in 2024"
```

## 📁 Repository Structure

```
ai-oracle-sqlcl-demo/
├── README.md
├── docs/
│   ├── SETUP_GUIDE.md           # Detailed setup instructions
│   ├── AUTONOMOUS_DB.md         # Autonomous Database setup
│   ├── TROUBLESHOOTING.md       # Common issues and solutions
│   └── EXAMPLE_QUERIES.md       # Natural language query examples
├── sql/
│   ├── setup/
│   │   ├── create_hr_schema.sql # HR database schema
│   │   └── load_sample_data.sql # Sample employee data
│   ├── examples/
│   │   ├── basic_queries.sql    # Simple examples
│   │   ├── analytics.sql        # Advanced analytics
│   │   └── dashboards.sql       # Dashboard queries
│   └── generated/               # AI-generated queries
├── config/
│   ├── cline_mcp_settings.json  # MCP configuration template
│   └── sqlcl_connections.md     # Connection setup guide
└── scripts/
    ├── docker_setup.sh          # Docker Oracle setup
    ├── test_connection.sh       # Connection validation
    └── start_demo.sh            # Complete demo startup
```

## 🎮 Demo Scenarios

### Basic Database Exploration
```
"Show me the structure of all tables and their relationships"
"Give me a sample of data from each table"
```

### HR Analytics
```
"Which departments have the most employees?"
"Show me salary distribution by department"
"Find employees hired in the last 6 months"
```

### Advanced Analytics
```
"Create a ranking of employees by salary within each department"
"Identify potential salary equity issues"
"Generate a comprehensive HR dashboard with key metrics"
```

### Data Quality Analysis
```
"Check for data quality issues like duplicates or missing values"
"Find any referential integrity problems"
"Analyze hiring trends over time"
```

## 🔧 Configuration Options

### Local Development (Docker)
- Quick setup with Oracle Free 23ai
- No licensing concerns
- Perfect for learning and demos

### Production Setup (Autonomous Database)
- Enterprise-grade Oracle features
- Managed service benefits
- See [docs/AUTONOMOUS_DB.md](docs/AUTONOMOUS_DB.md)

### Existing Oracle Database
- Works with any Oracle 19c+ instance
- Requires SQLcl 25.2+ with MCP support

## 🎯 Key Benefits

### For Developers
- **Faster Prototyping**: Natural language → SQL in seconds
- **Learning Accelerator**: See Oracle best practices in generated code
- **Reduced Syntax Burden**: Focus on logic, not memorizing SQL syntax

### For Data Analysts
- **Rapid Exploration**: Understand new schemas quickly
- **Complex Analytics**: Generate sophisticated queries conversationally
- **Documentation**: Auto-generate query explanations

### For Teams
- **Knowledge Sharing**: Natural language queries are self-documenting
- **Onboarding**: New team members can be productive immediately
- **Standards**: AI generates consistent, well-formatted SQL

## 🚨 Important Notes

### Security
- Use dedicated database users for demos
- MCP server runs locally with your credentials
- Never commit connection passwords to git

### AI Model Quality
- Better AI models (GPT-4, Claude) generate better SQL
- Results improve with more specific natural language prompts
- Always verify AI-generated queries before production use

### Oracle Features
- Works with all Oracle SQL features (joins, analytics, PL/SQL)
- Supports Oracle-specific functions and syntax
- Compatible with Oracle 19c, 21c, 23ai

## 🔍 Troubleshooting

### Common Issues
- **SQLcl not found**: Ensure SQLcl is in PATH or use full path in config
- **Connection fails**: Verify saved connections work independently
- **MCP not connecting**: Restart VS Code after configuration changes

See [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) for detailed solutions.

## 🎓 Learning Path

1. **Start with basic queries**: Table exploration, simple selects
2. **Try analytics**: Aggregations, grouping, rankings
3. **Explore advanced features**: Window functions, CTEs, analytics
4. **Create dashboards**: Multi-query analytical reports
5. **Generate documentation**: Schema analysis and documentation

## 🤝 Contributing

Contributions welcome! Areas for improvement:
- Additional demo scenarios
- More complex analytics examples
- Integration with other Oracle tools
- Performance optimization examples

## 📚 Additional Resources

- [Oracle SQLcl Documentation](https://docs.oracle.com/en/database/oracle/sql-developer-command-line/)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [Oracle Database Free](https://www.oracle.com/database/free/)
- [Oracle Autonomous Database](https://www.oracle.com/autonomous-database/)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Ready to transform your Oracle development experience?** Start with the quick setup and explore the power of AI-assisted database development!
