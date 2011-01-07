$(document).ready(function() {
  $('.reorderable').sortable({
    items:'tr',
    cursor:'move',
    axis:'y',
    opacity: 0.7,
    placeholder: "reorder-placeholder",
    forcePlaceholderSize: true,
    helper: function(e, tr)
      {
       var $originals = tr.children();
       var $helper = tr.clone();
       $helper.children().each(function(index)
       {
         // Set helper cell sizes to match the original sizes
         $(this).width($originals.eq(index).width())
       });
       return $helper;
      },
    start: function(event, ui)
      {
       var $column_count = ui.item.find('td').size();
       ui.placeholder.append("<td colspan='"+$column_count+"'></td>");
      },
    update: function()
      {
        var url = $(this).attr('data-reorder-url');
        var reorder_column = $(this).attr('data-reorder-column');
        $.post(url, $(this).sortable('serialize')+'&reorder_column='+reorder_column);
      }
  });
});
