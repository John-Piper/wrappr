library("wrappr")


###############
# Tests setup #
###############


msg_top <- "This is top message."

msg_bottom <- "This is bottom message."

msg_top_no_full_stop <- substring(msg_top, 1, nchar(msg_top) - 1)

msg_bottom_no_full_stop <- substring(msg_bottom, 1, nchar(msg_bottom) - 1)

full_stop <- "\\."

speech_mark <- "\""

print_box <- "\\[1\\] "

new_line <- "\\n"



#--------------------------------------------------------------------------------------------------------------------------------


#########
# Tests #
#########


test_that("Expected top and bottom message displays before and after func in msg_wrap function", {

  expected_result <- paste0(print_box, speech_mark, msg_top_no_full_stop, full_stop, speech_mark, new_line,
                              print_box, speech_mark, msg_bottom_no_full_stop, full_stop, speech_mark)

  expect_output(wrappr::msg_wrap(
    func = sum,
    c(1,2,3),
    before_func_msg = msg_top,
    after_func_msg = msg_bottom
  ), expected_result)

})


test_that("Expected return result from msg_wrap function", {

  expected_result <- 6

  test_output <- wrappr::msg_wrap(
    func = sum,
    c(1,2,3)
  )

  expect_equal(test_output, expected_result)

})
