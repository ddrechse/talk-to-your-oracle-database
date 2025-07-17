# Example Natural Language Queries

This document provides example natural language prompts you can use with Cline to explore the HR database and generate Oracle SQL queries.

## 🔍 Basic Database Exploration

### Connection and Setup
```
"Connect to hr_demo database"
"List all available database connections"
"Show me what tables exist in this database"
```

### Table Structure
```
"Show me the structure of the employees table"
"Describe all columns in the departments table"
"What are the relationships between employees and departments?"
```

### Sample Data
```
"Give me 5 sample records from the employees table"
"Show me a few examples from each table"
"What does the data look like in the departments table?"
```

## 📊 Basic Analytics

### Employee Counts
```
"How many employees do we have total?"
"How many employees are in each department?"
"Which department has the most employees?"
```

### Salary Analysis
```
"What's the average salary across all employees?"
"Show me salary ranges by department"
"Which department has the highest average salary?"
"Find the highest and lowest paid employees"
```

### Hiring Analysis
```
"Show me all employees hired in 2024"
"Who are our most recent hires?"
"Which departments have been hiring recently?"
"How many people were hired each month in 2024?"
```

## 🎯 Intermediate Analytics

### Department Performance
```
"Create a department scorecard with employee count, average salary, and salary range"
"Compare departments by their average salary and employee count"
"Which departments might be understaffed based on hiring patterns?"
```

### Employee Demographics
```
"Show me the distribution of employees by job role"
"Find employees who might be due for promotion based on tenure"
"Who are the managers and how many people report to them?"
```

### Compensation Analysis
```
"Calculate salary percentiles across the company"
"Find employees earning above the company average"
"Show me the salary distribution in each department"
"Identify potential salary equity issues"
```

## 🚀 Advanced Analytics

### Complex Queries
```
"Create a ranking of employees by salary within each department"
"Show me a hierarchical view of the management structure"
"Find employees whose salary is more than 2 standard deviations from their department average"
```

### Time-Based Analysis
```
"Analyze hiring trends over time and identify patterns"
"Show me year-over-year changes in department sizes"
"Calculate average tenure by department and job role"
```

### Business Intelligence
```
"Generate a comprehensive HR dashboard with key metrics"
"Create an executive summary of our workforce"
"Build a report showing department health indicators"
```

## 📈 Dashboard and Reporting

### Management Reports
```
"Create a monthly HR report showing headcount, new hires, and salary costs by department"
"Generate a workforce summary for executive presentation"
"Show me key HR metrics that leadership should monitor"
```

### Operational Reports
```
"Identify departments that need attention based on salary distribution or hiring patterns"
"Create a report of all employees hired in the last 6 months with their onboarding status"
"Show me a breakdown of our compensation structure"
```

### Strategic Analysis
```
"Analyze our talent pipeline and identify potential gaps"
"Compare our current workforce composition to industry standards"
"Predict future hiring needs based on current trends"
```

## 🔧 Data Quality and Maintenance

### Data Validation
```
"Check for any data quality issues in the employee records"
"Find duplicate records or inconsistencies"
"Validate that all foreign key relationships are intact"
```

### Auditing
```
"Show me any employees without department assignments"
"Find managers who don't have direct reports"
"Check for any salary outliers that might need review"
```

### Performance Analysis
```
"Identify queries that might benefit from indexing"
"Show me the most frequently accessed data patterns"
"Analyze database performance for common HR queries"
```

## 🎓 Learning Examples

### Oracle-Specific Features
```
"Show me how to use Oracle window functions with employee salary rankings"
"Create a query using Oracle's LISTAGG function to show department employee lists"
"Demonstrate Oracle hierarchical queries with the management structure"
```

### Advanced SQL Techniques
```
"Use a Common Table Expression (CTE) to analyze department performance"
"Create a pivot table showing employee counts by department and job role"
"Show me how to use Oracle's analytical functions for running totals"
```

### PL/SQL Examples
```
"Create a PL/SQL procedure to calculate bonus amounts based on performance"
"Write a function to determine employee tenure in years and months"
"Show me how to create a trigger that logs salary changes"
```

## 💡 Creative Use Cases

### Scenario Analysis
```
"If we gave everyone a 5% raise, what would be the budget impact by department?"
"Show me the cost impact of promoting all employees hired before 2022"
"Calculate the savings if we reduced contractor costs by hiring full-time employees"
```

### Predictive Queries
```
"Based on hiring patterns, predict how many employees we'll need next quarter"
"Identify employees who might be flight risks based on tenure and salary"
"Suggest optimal salary ranges for new hires in each department"
```

### Comparative Analysis
```
"Compare our salary structure to industry benchmarks"
"Show me how our workforce composition has changed over time"
"Analyze the ROI of different recruitment strategies"
```

## 📝 Documentation Generation

### Auto-Documentation
```
"Generate comprehensive documentation for the HR database schema"
"Create a data dictionary for all tables and columns"
"Document the business rules and relationships in our HR system"
```

### Query Documentation
```
"Explain the SQL query you just generated and why it works"
"Document the performance characteristics of this query"
"Create usage examples for this database structure"
```

## 🛠️ Tips for Better Results

### Be Specific
- Instead of "show me employees", try "show me employees hired in 2024 with their department and salary"
- Add context: "for the executive presentation" or "for budget planning"

### Use Business Language
- "high performers" instead of "employees with salary > average"
- "recent hires" instead of "employees with hire_date >= 2024-01-01"

### Ask for Explanations
- "Explain how this query works"
- "What Oracle features does this query use?"
- "How can I optimize this query?"

### Request Multiple Formats
- "Show me both summary statistics and detailed records"
- "Create both a table and a chart view"
- "Give me both the query and the business interpretation"

## 🔄 Iterative Refinement

### Follow-up Questions
After getting initial results:
- "Now filter this to show only IT department"
- "Add salary ranges to this analysis"
- "Sort this by hire date instead"
- "Make this query more efficient"

### Exploration Patterns
1. Start broad: "Show me department overview"
2. Drill down: "Focus on the IT department specifically"
3. Add complexity: "Include salary analysis and tenure calculations"
4. Optimize: "Make this query faster and add documentation"

## 📊 Expected AI Behavior

When you use these prompts, Cline should:
- Generate appropriate Oracle SQL syntax
- Include proper joins and relationships
- Format results in readable tables
- Add comments explaining the logic
- Suggest optimizations where relevant
- Handle edge cases and null values appropriately

The AI learns from your feedback, so don't hesitate to refine queries or ask for alternatives!