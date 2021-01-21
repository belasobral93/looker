view: order_items {
  sql_table_name: `looker-private-demo.ecomm.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: is_completed_sale {
    type: yesno
    sql: ${status} in ('Complete','Shipped','Processing') ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: "usd"
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: "usd"
  }

  measure: cumulative_total_sales {
    type: running_total
    sql: ${sale_price} ;;
    value_format_name: "usd"
  }

  measure: total_gross_revenue {
    type: sum
    sql: ${sale_price} ;;
    filters: [is_completed_sale: "yes"]
    value_format_name: "usd"
  }

  measure: percent_of_revenue {
    type: percent_of_total
    sql: ${total_gross_revenue};;
    value_format_name: decimal_2
  }

  measure: total_gross_margin {
    type: number
    sql: ${total_gross_revenue} - ${inventory_items.total_cost} ;;
    value_format_name: "usd"
    drill_fields: [inventory_items.product_category, inventory_items.product_brand]
  }

  measure: average_gross_margin {
    type: average
    sql: ${sale_price} - ${inventory_items.cost} ;;
    filters: [is_completed_sale: "yes"]
    value_format_name: "usd"
  }

  measure: gross_margin_percent {
    type: number
    sql: ${total_gross_margin} / NULLIF(${total_gross_revenue},0)  ;;
    value_format_name: percent_2
  }

  measure: num_items_returned {
    type: count
    filters: [returned_date: "-NULL"]
  }

  measure: item_return_rate {
    description: "Number of Items Returned / total number of items sold"
    type: number
    sql: ${num_items_returned} / ${count} ;;
    value_format_name: percent_2
  }

  measure: num_customers_return_item {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [status: "Returned"]
    description: "Number of users who have returned an item at some point"
  }

  measure: percent_of_users_with_returns {
    type: number
    sql:  ${num_customers_return_item} / ${total_customers};;
    description: "Number of Customer Returning Items / total number of customers"
    value_format_name: percent_2
  }

  measure: total_customers {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: avg_spend_per_customer {
    type: number
    sql: ${total_sale_price} / ${total_customers} ;;
    description: "Total Sale Price / total number of customers"
    value_format_name: "usd"
  }



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
