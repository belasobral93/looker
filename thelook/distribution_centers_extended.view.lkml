include: "./distribution_centers.view"

view: distribution_centers_extended {
  extends: [distribution_centers]
  dimension: name {
    view_label: "Inventory Items"
    label: "Distribution Centers Name"
  }
}
