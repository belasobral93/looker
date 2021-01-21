# If necessary, uncomment the line below to include explore_source.
# include: "302.model.lkml"

view: order_facts {
  derived_table: {
    explore_source: order_items {
      column: count { field: users.count }
      column: created_date { field: users.created_date }
      column: total_gross_revenue {}
      column: created_date {}
      column: avg_spend_per_customer {}
      column: gross_margin_percent {}
    }
  }
  dimension: count {
    type: number
  }
  dimension: created_date {
    type: date
  }
  dimension: total_gross_revenue {
    value_format: "$#,##0.00"
    type: number
  }

  dimension: avg_spend_per_customer {
    description: "Total Sale Price / total number of customers"
    type: number
  }
  dimension: gross_margin_percent {
    value_format: "#,##0.00%"
    type: number
  }
}
