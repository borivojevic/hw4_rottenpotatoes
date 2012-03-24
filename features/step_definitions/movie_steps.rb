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
