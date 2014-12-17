class @Accordion
  constructor: ->
    $("[role='tab']").bind "click", (e) =>
      e.preventDefault()
      $tab = $(e.target)
      tabId = $tab.attr "id"
      panelId = $tab.attr "aria-controls"
      $tabpanel = $("##{panelId}")

      @._togglePanel($tabpanel, $tab)

  _togglePanel: ($panel, $tab) ->
    isSelected = $panel.attr "aria-selected"
    isHidden = $panel.attr "aria-hidden"
    isExpanded = $tab.attr "aria-expanded"

    $panel.slideToggle "fast"
    $panel.attr "aria-hidden", !isHidden
    $panel.attr "aria-selected", !isSelected
    $tab.attr "aria-expanded", !isExpanded
