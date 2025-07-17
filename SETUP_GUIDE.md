# Complete Setup Guide

This guide provides detailed step-by-step instructions for setting up AI-powered Oracle development with SQLcl MCP Server.

## Step 1: Database Setup

### Option A: Docker Setup (Recommended for Demo)

1. **Install Docker** if not already installed
2. **Start Oracle Free 23ai container**:
   ```bash
   docker run --name oracle-demo -d -p 1521:1521 \
     -e ORACLE_PASSWORD=Welcome12345 \
     -e APP_USER=hr \
     -e APP_USER_PASSWORD=Welcome12345 \
     gvenzl/oracle-free:23.7-slim-faststart
   ```

3. **Wait for database startup** (2-3 minutes):
   ```bash
   docker logs -f oracle-demo
   # Wait for "DATABASE IS READY TO USE!"
   ```

4. **Test connection**:
   ```bash
   docker exec -it oracle-demo sqlplus hr/Welcome12345@FREEPDB1
   ```

### Option B: Oracle Autonomous Database

See [AUTONOMOUS_DB.md](AUTONOMOUS_DB.md) for complete Autonomous Database setup.

### Option C: Existing Oracle Installation

Use your existing Oracle 19c+ database with proper user privileges.

## Step 2: SQLcl Installation and Configuration

### Install SQLcl 25.2+

1. **Download SQLcl** from [Oracle Downloads](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/)
2. **Extract and add to PATH**:
   ```bash
   # Example for macOS/Linux
   export PATH=$PATH:/path/to/sqlcl/bin
   
   # Test installation
   sql -V
   ```

### Create Sample HR Schema

1. **Connect to database**:
   ```bash
   sql hr/Welcome12345@localhost:1521/FREEPDB1
   ```

2. **Run schema creation script**:
   ```sql
   @sql/setup/create_hr_schema.sql
   @sql/setup/load_sample_data.sql
   ```

3. **Verify data**:
   ```sql
   SELECT COUNT(*) FROM employees;
   SELECT COUNT(*) FROM departments;
   ```

### Create Saved Connection for MCP

1. **Save connection with password**:
   ```sql
   conn -save hr_demo -savepwd
   exit
   ```

2. **Test saved connection**:
   ```bash
   sql -name hr_demo
   # Should connect without password prompt
   ```

## Step 3: VS Code Environment Setup

### Install VS Code Extensions

1. **Oracle SQL Developer Extension**:
   - Open VS Code Extensions (`Cmd/Ctrl + Shift + X`)
   - Search for "Oracle SQL Developer"
   - Install and reload VS Code

2. **Cline Extension**:
   - Search for "Cline"
   - Install and reload VS Code

### Configure Oracle SQL Developer Extension

1. **Create database connection**:
   - Click Oracle icon in sidebar
   - Add new connection
   - Use connection details: `hr/Welcome12345@localhost:1521/FREEPDB1`

2. **Test connection**:
   - Connect and browse tables
   - Verify EMPLOYEES and DEPARTMENTS tables are visible

### Configure Cline Extension

1. **Set up AI API**:
   - Click Cline icon in sidebar
   - Choose "Use your own API key"
   - Select provider (Claude, OpenAI, etc.)
   - Enter API key and select model

2. **Configure MCP server**:
   - Click "Manage MCP Servers"
   - Click Settings icon
   - Add configuration to `cline_mcp_settings.json`:
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

3. **Restart VS Code** to apply changes

## Step 4: Start MCP Server and Test

### Start SQLcl MCP Server

```bash
sql -mcp
```

Expected output:
```
---------- MCP SERVER STARTUP ----------
MCP Server started successfully on [timestamp]
Press Ctrl+C to stop the server
----------------------------------------
```

### Verify MCP Connection in Cline

1. **Check Connected MCP Servers**:
   - In Cline, click "Manage MCP Servers"
   - Verify "SQLcl" is listed with 5 tools:
     - list-connections
     - connect
     - disconnect
     - run-sql
     - run-sqlcl

### First Test Query

Try this in Cline:
```
"List available database connections and connect to hr_demo"
```

Expected result: Shows available connections and connects successfully.

## Step 5: Demo Validation

### Basic Queries

1. **Table exploration**:
   ```
   "Show me all tables in the database and their row counts"
   ```

2. **Data structure**:
   ```
   "Show me the structure of the employees table"
   ```

3. **Sample data**:
   ```
   "Give me 5 sample employee records"
   ```

### Analytics Queries

1. **Simple analytics**:
   ```
   "How many employees are in each department?"
   ```

2. **Date-based analysis**:
   ```
   "Show me employees hired in 2024"
   ```

3. **Salary analysis**:
   ```
   "Which department has the highest average salary?"
   ```

## Step 6: Advanced Configuration

### Performance Optimization

1. **Enable SQL plan analysis**:
   ```sql
   SET AUTOTRACE ON
   SET TIMING ON
   ```

2. **Configure query formatting**:
   ```sql
   SET PAGESIZE 100
   SET LINESIZE 200
   ```

### Security Configuration

1. **Create dedicated MCP user**:
   ```sql
   -- As DBA
   CREATE USER mcp_demo IDENTIFIED BY SecurePassword123;
   GRANT CONNECT, RESOURCE TO mcp_demo;
   GRANT SELECT, INSERT, UPDATE, DELETE ON hr.employees TO mcp_demo;
   GRANT SELECT, INSERT, UPDATE, DELETE ON hr.departments TO mcp_demo;
   ```

2. **Use restricted connection**:
   ```bash
   sql mcp_demo/SecurePassword123@localhost:1521/FREEPDB1
   conn -save mcp_restricted -savepwd
   ```

### Logging Configuration

1. **Enable MCP logging**:
   ```sql
   -- Check MCP activity log
   SELECT * FROM DBTOOLS$MCP_LOG ORDER BY ID DESC;
   ```

2. **Monitor sessions**:
   ```sql
   -- View active sessions
   SELECT module, action, program FROM v$session 
   WHERE module LIKE '%MCP%';
   ```

## Troubleshooting

### Common Issues

1. **SQLcl not found**:
   - Verify PATH includes SQLcl bin directory
   - Use full path in MCP configuration if needed

2. **Connection refused**:
   - Check Oracle database is running
   - Verify port 1521 is accessible
   - Check firewall settings

3. **MCP server won't start**:
   - Ensure Java 17+ is installed
   - Check SQLcl version is 25.2+
   - Verify no other process is using MCP port

4. **Cline can't connect to MCP**:
   - Restart VS Code after configuration changes
   - Check MCP server is running in terminal
   - Verify cline_mcp_settings.json syntax

### Validation Commands

```bash
# Test database connectivity
sql hr/Welcome12345@localhost:1521/FREEPDB1 -S -L

# Test saved connection
sql -name hr_demo -S -L

# Verify SQLcl version
sql -V

# Check Java version
java -version
```

## Next Steps

Once setup is complete:

1. **Explore the example queries** in `sql/examples/`
2. **Try progressive complexity** - start simple, build to advanced
3. **Compare AI vs manual** - use both Cline and SQL Developer
4. **Document your discoveries** - save interesting AI-generated queries
5. **Experiment with your own data** - apply to real projects

## Support

For issues:
1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Review Oracle SQLcl documentation
3. Check Cline extension documentation
4. Validate each component individually