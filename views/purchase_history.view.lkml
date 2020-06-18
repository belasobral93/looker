view: purchase_history {
  derived_table: {
    explore_source: order_items {
      column: user_id {field: order_items.user_id}
      column: order_id {field: order_items.order_id}
      column: created_at {field: order_items.created_date}
      column: sale_price {field: order_items.sale_price}
      derived_column: running_order_total {
        sql:  running_total(${sale_price}) ;;
      }
      derived_column: purchase_order {
        sql: ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at) ;;
      }
    }
  }
#   # Define the view's fields as desired
#   dimension: user_id {hidden: yes}
#   dimension: order_id {hidden: yes}
#   dimension: created_at {hidden: yes}
#   dimension: sale_price {type: number}
#   dimension: running_order_total {type: number}
#   dimension: purchase_order {type: number}
}
