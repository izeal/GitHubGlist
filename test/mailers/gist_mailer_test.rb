require 'test_helper'

class GistMailerTest < ActionMailer::TestCase
  test "comment" do
    mail = GistMailer.comment
    assert_equal "Comment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
