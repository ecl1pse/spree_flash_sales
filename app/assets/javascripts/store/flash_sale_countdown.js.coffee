$(document).ready ->

  # Forked from: https://github.com/suryart/spree_active_sale/blob/master/vendor/assets/javascripts/spree_active_sale/event_timer.js
  $("[data-countdown]").each ->
    flashSaleEndDate = $(this).attr("data-countdown")
    timeLayout = $(this).attr("data-layout")

    # use a JS friendly type
    endDateTime = new Date(flashSaleEndDate)

    # Return the timezone difference between UTC and User Local Time
    userTimeZoneDiff = endDateTime.getTimezoneOffset()
    # Since there are 60,000 milliseconds in a minute
    MS_PER_MINUTE = 60000
    # Event's final end date will depend on the final subtracted date as:
    adjustedFlashSaleEndDate = new Date(endDateTime - userTimeZoneDiff * MS_PER_MINUTE)
    $(this).countdown(
      until: adjustedFlashSaleEndDate
      layout: timeLayout
    )
