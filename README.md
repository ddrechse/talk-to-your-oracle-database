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

### 1. Set Up Oracle Database

**Option A: Automated Docker Setup (Recommended)**
```bash
git clone <this-repo>
cd ai-oracle-sqlcl-demo
chmod +x scripts/docker_setup.sh
./scripts/docker_setup.sh
```

**Option B: Manual Docker Setup**
```bash
# Start Oracle Free 23ai container
docker run --name oracle-demo -d -p 1521:1521 \
  -e ORACLE_PASSWORD=Welcome12345 \
  -e APP_USER=hr \
  -e APP_USER_PASSWORD=Welcome12345 \
  gvenzl/oracle-free:23.7-slim-faststart

# Wait for database to start (2-3 minutes)
docker logs -f oracle-demo
```

### 2. Create HR Schema and Load Data

```bash
# Connect to database
sql hr/Welcome12345@localhost:1521/FREEPDB1

# Create schema and load sample data
@sql/setup/create_hr_schema.sql
@sql/setup/load_sample_data.sql
```

### 3. Set Up VS Code Environment

```bash
# Open project in VS Code
code .
```

**Install Extensions**:
- **Oracle SQL Developer** - Database management
- **Cline** - AI assistant

### 4. Configure MCP Connection

```bash
# Create saved connection for MCP
sql hr/Welcome12345@localhost:1521/FREEPDB1
conn -save hr_demo -savepwd
exit
```

### 5. Configure Cline MCP Settings

In VS Code, add to `cline_mcp_settings.json`:
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

### 6. Start AI-Database Bridge

```bash
sql -mcp
```

### 7. Try Natural Language Queries

In Cline, try:
```
"Connect to hr_demo and show me all employees hired in 2024"
```

## 📁 Repository Structure

```
ai-oracle-sqlcl-demo/
├── README.md                    # This file - complete guide
├── SETUP_GUIDE.md              # Detailed setup instructions
├── docs/
│   ├── TROUBLESHOOTING.md      # Common issues and solutions
│   └── EXAMPLE_QUERIES.md      # Natural language query examples
├── sql/
│   └── setup/
│       ├── create_hr_schema.sql # HR database schema
│       └── load_sample_data.sql # Sample employee data
└── scripts/
    └── docker_setup.sh         # Automated Docker Oracle setup
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
For enterprise/production use, you can also connect to Oracle Autonomous Database. The same natural language queries work identically - just use different connection parameters. See [SETUP_GUIDE.md](SETUP_GUIDE.md) for Autonomous Database configuration.

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

1. **Start with basic queries**: See [docs/EXAMPLE_QUERIES.md](docs/EXAMPLE_QUERIES.md) for natural language examples
2. **Try analytics**: Aggregations, grouping, rankings
3. **Explore advanced features**: Window functions, CTEs, analytics  
4. **Create dashboards**: Multi-query analytical reports
5. **Generate documentation**: Schema analysis and documentation

For detailed setup instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md).

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