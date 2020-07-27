1. Link to the application:
   https://gamblingapplication.herokuapp.com/login
   
2. Test username:user
   Test password: pass

3. After logging in ,
	a. 1st column is the betting column
	b. 2nd column shows the session total profit,win and loss 
	c. 3rd column shows the total account profit,win and loss

4. Rules
	a. The session win amount is calculated as 2 times the bet amount plus the previous session profit
	b. The session loss	amount is calculated as previous session loss minus the bet amount
	c. The session profit is calculated as difference between session win and session loss.
	e. The same calculations are performed for the account total
	d. Each time the bet button is clicked both the session total values in the second column and account total values in the third column are updated
	e. The account totals are also updated when the logout button is clicked
	
	![gambling](https://user-images.githubusercontent.com/22544164/88498307-9e2c9080-cf77-11ea-866c-cd528289ed06.jpg)

