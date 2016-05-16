Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    m = Movie.new(movie)
    m.save()
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.match(/#{e1}.*#{e2}/m), "#{e1} should come before #{e2}"
end

Then /the movies should be sorted by "(.*)"/ do |field|
  prev=""
  Movie.find(:all, :order => field).each do |movie|
    curr = movie.send(field)
    step "I should see \"#{prev}\" before \"#{curr}\"" if prev != ""
    prev = curr 
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/\s*,\s*/).each do |rating|
    step "I #{uncheck}check \"ratings_#{rating}\""
  end 
end

Then /^(?:|I )should see \/([^\/]*)\/ inside of (.*)$/ do |regexp,element|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath("//*/#{element}", :text => regexp)
  else
    assert page.has_xpath?("//*/#{element}", :text => regexp)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/ inside of (.*)$/ do |regexp,element|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath("//*/#{element}", :text => regexp)
  else
    assert page.has_no_xpath?("//*/#{element}", :text => regexp)
  end
end

Then /^(?:|I )should see all of the movies$/ do 
  Movie.find(:all).each do |movie|
    step "I should see \"#{movie.title}\""    
  end 
end

Then /^(?:|I )should see none of the movies$/ do 
  Movie.find(:all).each do |movie|
    step "I should not see \"#{movie.title}\""    
  end 
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  movie = Movie.find_by_title(title)
  assert movie.director == director, "#{title} director is #{movie.director} and it should be #{director}"
end