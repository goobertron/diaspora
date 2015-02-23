Then /I should see the mention modal/ do
  step %{I should see a "#mentionModal.in"}
end

And /^I want to mention (?:him|her) from the profile$/ do
  find('#mention_button').click
  within('#mentionModal') do
    click_publisher
  end
end

When /^(.*) in the modal window$/ do |action|
  within('#facebox') do
    step action
  end
end

When /^(.*) in the mention modal$/ do |action|
  within('#mentionModal') do
    step action
  end
end

