# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
  Movie.create!(
    :title => movie[:title],
    :rating => movie[:rating],
    :director => movie[:director],
    :release_date => movie[:release_date]
  )
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_title, director|
  page.body.should have_content("Details about #{movie_title}")
  page.body.should have_content("#{director}")
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.should =~ /#{e1}.*#{e2}/
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
    if uncheck == "un"
      step %Q{I uncheck "ratings_#{rating}"}
    else
      step %Q{I check "ratings_#{rating}"}
    end
  end
end

Then /I should see all of the movies/ do
  rows = find("table#movies tbody").all('tr').count
  rows.should == Movie.count
end
