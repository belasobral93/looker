view: inventory_items {
  sql_table_name: `looker-private-demo.ecomm.inventory_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    type: string
    sql: ${TABLE}.product_brand ;;
    view_label: "Products"
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
    view_label: "Products"
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.product_department ;;
    view_label: "Products"
  }

  dimension: product_distribution_center_id {
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
    view_label: "Products"
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
    view_label: "Products"
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
    view_label: "Products"
  }

  dimension: product_retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
    view_label: "Products"
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
    view_label: "Products"
  }

  dimension_group: sold {
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
    sql: ${TABLE}.sold_at ;;
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
  }

  measure: average_cost {
    type: average
    sql: ${cost} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, product_name, products.name, products.id, order_items.count]
  }
}
