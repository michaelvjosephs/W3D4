# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([ { user_name: 'Lee' }, { user_name: 'Michael' } ])

polls = Poll.create([
  { author_id: users[0].id, title: "Best way to grow peanuts" },
  { author_id: users[1].id, title: "Best place to get free pizza" } ])

questions = Question.create([
  { text: "What kind of soil should I use?", poll_id: polls[0].id },
  { text: "What city should I start in?", poll_id: polls[1].id } ])

answer_choices = AnswerChoice.create([
  { text: "brown soil", question_id: questions[0].id },
  { text: "black soil", question_id: questions[0].id },
  { text: "NYC", question_id: questions[1].id },
  { text: "Boston", question_id: questions[1].id }
  ])

responses = Response.create([
  { answer_choice_id: answer_choices[0].id, user_id: users[0].id },
  { answer_choice_id: answer_choices[1].id, user_id: users[1].id },
  { answer_choice_id: answer_choices[2].id, user_id: users[0].id },
  { answer_choice_id: answer_choices[3].id, user_id: users[1].id }
  ])
