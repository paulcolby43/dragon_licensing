module LicensesHelper
  def licenses_sort_link(column, title = nil)
    title ||= column.titleize
    direction = (column == licenses_sort_column && licenses_sort_direction == "asc") ? "desc" : "asc"
    icon = (licenses_sort_direction == "asc" ? "fa fa-chevron-up" : "fa fa-chevron-down")
    icon = (column == licenses_sort_column ? icon : "")
    link_to "#{title} <i class='#{icon}'></i>".html_safe, {licenses_column: column, licenses_direction: direction}
  end
end
