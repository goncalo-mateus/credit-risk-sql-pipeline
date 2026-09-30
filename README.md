# Credit Lifecycle & Risk Operations Pipeline

An end-to-end credit operations and risk analytics framework built in SQL (SQLite) that models the full retail credit lifecycle—from initial loan application to contract origination and repayment monitoring. The project implements a relational schema (DDL), populates relational mock data (DML), and executes advanced analytical queries (DQL) to track channel conversion rates, portfolio default risk, and outstanding repayment bottlenecks.

Designed for credit operations management, financial risk mitigation, and FinTech decision-making workflows.

---

## Key Capabilities & Features

* **Relational Schema Architecture (DDL):** Defines a fully normalized 4-table relational database model (`clientes`, `pedidos_credito`, `contratos_credito`, `pagamentos`) with primary/foreign key constraints and dynamic default tracking.
* **Credit Lifecycle Data Synthesis (DML):** Simulates realistic loan application pipelines, credit score evaluations, loan origination terms, and scheduled vs. late installment payments.
* **Origination & Channel Funnel Analytics (DQL):** Aggregates application metrics across acquisition channels (Website vs. Retail POS) to evaluate approval conversion rates and origination efficiency.
* **Early Warning & Default Monitoring (DQL):** Queries unfulfilled installment payments (`NULL` payment dates) and tracks overdue days (`dias_atraso`) to isolate high-risk contracts and mitigate credit loss.
* **Operational Control & Escalation Support:** Provides structured data outputs designed to bridge Middle-Office risk reporting with Front-Office operational decision-making.

---

## Tech Stack & Tools

* **Database Engine:** SQLite 3
* **Language:** SQL (Data Definition, Manipulation, and Query Language)
* **Development Environment:** Visual Studio Code / GitHub Codespaces (`vscode-sqlite`)
* **Version Control:** Git & GitHub

---

## Quantitative & Relational Framework

The pipeline operates on the following analytical and logical core:

1. **Channel Conversion Rate (%):**
   $$\text{Taxa de Aprovação} = \left( \frac{\sum \text{Pedidos Aprovados}}{\text{Total de Pedidos}} \right) \times 100$$

2. **Overdue Risk Isolation (DQL Logic):**
   $$\text{Status de Incumprimento} = \begin{cases} \text{Pendente / Em Risco}, & \text{se } \text{data\_pagamento} \text{ IS NULL} \\ \text{Regularizado}, & \text{se } \text{data\_pagamento} \text{ IS NOT NULL} \end{cases}$$

3. **Relational Entity Mapping:**
   $$\text{Clientes} \xrightarrow{1:N} \text{Pedidos} \xrightarrow{1:1} \text{Contratos} \xrightarrow{1:N} \text{Pagamentos}$$
