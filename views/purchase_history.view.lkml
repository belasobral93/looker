view: purchase_history {
  derived_table: {
    explore_source: order_items {
      column: user_id {field: order_items.user_id}
      column: order_id {field: order_items.order_id}
      column: created_at {field: order_items.created_date}
      column: sale_price {field: order_items.sale_price}
      derived_column: purchase_order {
        sql: ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at) ;;
      }
    }
  }

dimension: user_id {}
dimension: order_id {}
dimension: created_at {}
dimension: sale_price {}
dimension: purchase_order {}

measure: order_total {
  type: sum
  sql: ${sale_price} ;;
}
measure: running_order_total {
  type: running_total
  sql: ${sale_price} ;;
}
}
