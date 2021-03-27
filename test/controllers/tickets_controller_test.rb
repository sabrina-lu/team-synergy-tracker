require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    setup_tickets
  end
  
#   create ticket tests  
   test "Should successfully create a ticket" do 
     assert_difference('Ticket.count', 1) do
       assert_difference('TicketResponse.count', 5) do
           post create_team_ticket_url(@team_1), params: {creator_id: @user_4.id, date: @t_4.date, users: [@user_1.id], answer1: 1, answer2: 2, answer3: 3, answer4: 4, answer5: 5}  
       end
     end
   end
    
  test "Should successfully redirect user to their dashboard after ticket creation" do
    post create_team_ticket_url(@team_1), params: {creator_id: @user_4.id, date: @t_4.date, users: [@user_1.id], answer1: 1, answer2: 2, answer3: 3, answer4: 4, answer5: 5}
    assert_redirected_to user_dashboard_url
  end

#   TODO:FIX THESE TEST AFTER IMPLEMENTING CREATE TICKET FORM
    
   test "should show manager any ticket they want to view" do
     @manager = Manager.create(watiam: "jsmith", first_name: "John", last_name: "Smith", password: "Password")
     t = [@t_1, @t_2, @t_3]
     for i in 0..2 do
         TicketResponse.create(ticket_id: t[i].id, question_number: 1, answer: 1)
         TicketResponse.create(ticket_id: t[i].id, question_number: 2, answer: 2)
         TicketResponse.create(ticket_id: t[i].id, question_number: 3, answer: 3)
         TicketResponse.create(ticket_id: t[i].id, question_number: 4, answer: 2)
         TicketResponse.create(ticket_id: t[i].id, question_number: 5, answer: 7)
     end      
     login_as_manager
     get ticket_url(@t_1)
     assert_response :success
     get ticket_url(@t_2)
     assert_response :success
     get ticket_url(@t_3)
     assert_response :success
   end
end
