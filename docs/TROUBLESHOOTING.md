# Troubleshooting Guide

This guide helps resolve common issues when setting up and using the AI-powered Oracle development environment.

## 🔍 Quick Diagnostics

### System Check Commands
```bash
# Check SQLcl version
sql -V

# Check Java version
java -version

# Check Docker container
docker ps
docker logs oracle-demo

# Test database connection
sql hr/Welcome12345@localhost:1521/FREEPDB1 -S -L

# Test saved connection
sql -name hr_demo -S -L
```

## 🚨 Common Issues and Solutions

### 1. SQLcl Not Found

**Error**: `command not found: sql`

**Solutions**:
```bash
# Option A: Add to PATH
export PATH=$PATH:/path/to/sqlcl/bin
echo 'export PATH=$PATH:/path/to/sqlcl/bin' >> ~/.bashrc

# Option B: Use full path in MCP config
{
  "command": "/full/path/to/sqlcl/bin/sql",
  "args": ["-mcp"]
}

# Option C: Create symlink
sudo ln -s /path/to/sqlcl/bin/sql /usr/local/bin/sql
```

### 2. Database Connection Issues

**Error**: `ORA-12541: TNS:no listener`

**Solutions**:
```bash
# Check Docker container is running
docker ps
docker start oracle-demo

# Check port is accessible
telnet localhost 1521

# Verify connection string format
sql hr/Welcome12345@localhost:1521/FREEPDB1

# For Docker, ensure proper service name
sql hr/Welcome12345@//localhost:1521/FREEPDB1
```

**Error**: `ORA-01017: invalid credential or not authorized`

**Solutions**:
```bash
# Wait for database to fully start
docker logs -f oracle-demo
# Look for "DATABASE IS READY TO USE!"

# Check credentials match container setup
docker exec -it oracle-demo sqlplus hr/Welcome12345@FREEPDB1

# Reset user password if needed
docker exec -it oracle-demo sqlplus sys/Welcome12345@FREEPDB1 as sysdba
ALTER USER hr IDENTIFIED BY Welcome12345;
```

### 3. MCP Server Issues

**Error**: `MCP Server failed to start`

**Solutions**:
```bash
# Check SQLcl version supports MCP
sql -V  # Should be 25.2.0 or higher

# Check Java version
java -version  # Should be 17 or higher

# Start MCP server manually
sql -mcp

# Check for port conflicts
lsof -i :8080  # Default MCP port
```

**Error**: `No connection found for server`

**Solutions**:
```json
// Check cline_mcp_settings.json format
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

```bash
# Restart VS Code after config changes
# Ensure MCP server is running
sql -mcp
```

### 4. Cline Extension Issues

**Error**: `Cline can't connect to MCP server`

**Solutions**:
1. **Restart VS Code** after configuration changes
2. **Check MCP server status**:
   ```bash
   sql -mcp
   # Should show: "MCP Server started successfully"
   ```
3. **Verify configuration**:
   - Open Cline → Manage MCP Servers
   - Check "SQLcl" is listed under Connected MCP Servers
   - Verify 5 tools are available: list-connections, connect, disconnect, run-sql, run-sqlcl

4. **Check API configuration**:
   - Ensure valid API key for your AI provider
   - Verify model selection is appropriate

### 5. Saved Connection Issues

**Error**: `Password prompts when using saved connections`

**Solutions**:
```bash
# Delete and recreate saved connection
sql hr/Welcome12345@localhost:1521/FREEPDB1
conn -save hr_demo -savepwd
exit

# Test saved connection
sql -name hr_demo  # Should not prompt for password
```

**Error**: `Connection 'hr_demo' already exists`

**Solutions**:
```sql
-- Delete existing connection
connmgr delete -conn hr_demo

-- Create new connection
conn -save hr_demo -savepwd
```

### 6. Docker Oracle Issues

**Error**: `Docker container won't start`

**Solutions**:
```bash
# Check Docker daemon is running
docker version

# Remove existing container
docker rm -f oracle-demo

# Restart with fresh container
docker run --name oracle-demo -d -p 1521:1521 \
  -e ORACLE_PASSWORD=Welcome12345 \
  -e APP_USER=hr \
  -e APP_USER_PASSWORD=Welcome12345 \
  gvenzl/oracle-free:23.7-slim-faststart

# Monitor startup
docker logs -f oracle-demo
```

**Error**: `Port 1521 already in use`

**Solutions**:
```bash
# Find what's using port 1521
lsof -i :1521

# Use different port
docker run --name oracle-demo -d -p 1522:1521 \
  -e ORACLE_PASSWORD=Welcome12345 \
  -e APP_USER=hr \
  -e APP_USER_PASSWORD=Welcome12345 \
  gvenzl/oracle-free:23.7-slim-faststart

# Update connection string
sql hr/Welcome12345@localhost:1522/FREEPDB1
```

## 🔧 Advanced Troubleshooting

### Oracle SQL Developer Extension Issues

**Problem**: Extension won't connect to database

**Solutions**:
1. **Check extension is installed and enabled**
2. **Create new connection**:
   - Host: localhost
   - Port: 1521
   - Service: FREEPDB1
   - Username: hr
   - Password: Welcome12345
3. **Test connection** before saving
4. **Restart VS Code** if connection fails

### Performance Issues

**Problem**: Slow query execution

**Solutions**:
```sql
-- Check database statistics
SELECT * FROM user_tables;

-- Analyze tables
ANALYZE TABLE employees COMPUTE STATISTICS;
ANALYZE TABLE departments COMPUTE STATISTICS;

-- Check execution plans
EXPLAIN PLAN FOR SELECT * FROM employees;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

### Memory Issues

**Problem**: Out of memory errors

**Solutions**:
```bash
# Increase Docker memory
docker run --name oracle-demo -d -p 1521:1521 \
  --memory=4g \
  -e ORACLE_PASSWORD=Welcome12345 \
  -e APP_USER=hr \
  -e APP_USER_PASSWORD=Welcome12345 \
  gvenzl/oracle-free:23.7-slim-faststart
```

## 🔍 Debugging Steps

### 1. Component-by-Component Testing

**Test Database**:
```bash
sql hr/Welcome12345@localhost:1521/FREEPDB1
SELECT COUNT(*) FROM employees;
```

**Test SQLcl MCP**:
```bash
sql -mcp
# Should show startup message
```

**Test Cline Connection**:
- Open Cline
- Check "Connected MCP Servers"
- Try: "List available database connections"

### 2. Logging and Monitoring

**Enable SQLcl Logging**:
```sql
SET ECHO ON
SET TIMING ON
SET AUTOTRACE ON
```

**Check MCP Activity**:
```sql
-- View MCP operation log
SELECT * FROM DBTOOLS$MCP_LOG ORDER BY ID DESC;

-- Monitor active sessions
SELECT module, action, program FROM v$session 
WHERE module LIKE '%MCP%' OR program LIKE '%sql%';
```

### 3. Environment Validation

**Check Environment Variables**:
```bash
echo $JAVA_HOME
echo $PATH
echo $TNS_ADMIN  # For Autonomous DB
```

**Verify File Permissions**:
```bash
ls -la /path/to/sqlcl/bin/sql
# Should be executable
```

## 🚑 Emergency Recovery

### Complete Reset

1. **Stop all processes**:
   ```bash
   # Stop MCP server (Ctrl+C)
   # Stop Docker container
   docker stop oracle-demo
   ```

2. **Clean up**:
   ```bash
   docker rm oracle-demo
   rm -rf ~/.dbtools  # Removes saved connections
   ```

3. **Fresh start**:
   ```bash
   # Restart Docker container
   docker run --name oracle-demo -d -p 1521:1521 \
     -e ORACLE_PASSWORD=Welcome12345 \
     -e APP_USER=hr \
     -e APP_USER_PASSWORD=Welcome12345 \
     gvenzl/oracle-free:23.7-slim-faststart
   
   # Wait for startup
   docker logs -f oracle-demo
   
   # Recreate schema
   sql hr/Welcome12345@localhost:1521/FREEPDB1
   @sql/setup/create_hr_schema.sql
   @sql/setup/load_sample_data.sql
   ```

### Backup Working Configuration

**Save working setup**:
```bash
# Export working Docker image
docker commit oracle-demo my-oracle-demo:working

# Backup SQLcl connections
cp -r ~/.dbtools ~/.dbtools.backup

# Save VS Code settings
cp ~/.vscode/settings.json ~/.vscode/settings.json.backup
```

## 📞 Getting Help

### Check Documentation
- [Oracle SQLcl Documentation](https://docs.oracle.com/en/database/oracle/sql-developer-command-line/)
- [Cline Extension Documentation](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev)
- [Oracle Database Free](https://www.oracle.com/database/free/)

### Community Resources
- Oracle Community Forums
- Stack Overflow (tags: oracle, sqlcl, vscode)
- GitHub Issues for specific extensions

### Diagnostic Information to Collect

When seeking help, provide:
```bash
# System information
uname -a
docker version
sql -V
java -version

# Configuration files
cat ~/.vscode/settings.json
cat cline_mcp_settings.json

# Error logs
docker logs oracle-demo
# VS Code Developer Tools → Console
```

## 🎯 Prevention Tips

### Regular Maintenance
- **Update SQLcl regularly** for latest MCP features
- **Keep Docker images updated** for security
- **Backup working configurations** before changes
- **Test connections** after system updates

### Best Practices
- **Use version control** for SQL scripts and configurations
- **Document custom configurations** for team sharing
- **Monitor resource usage** to prevent memory issues
- **Regular database statistics** updates for performance

### Development Workflow
1. **Test in isolation** - validate each component separately
2. **Use saved connections** - avoid repeated password entry
3. **Monitor logs** - watch for warnings before they become errors
4. **Version control** - track configuration changes