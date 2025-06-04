McKinsey & Company SQL Interview Question For Data Analyst:
CTC - 26 LPA

You’re a consultant for a major pizza chain that will be running a promotion where all 3-topping pizzas will be sold for a fixed price, and are trying to understand the costs involved.

Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.

Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.

Notes:

Do not display pizzas where a topping is repeated. For example, ‘Pepperoni,Pepperoni,Onion Pizza’.
Ingredients must be listed in alphabetical order. For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.

pizza_toppings Table:

Column Name Type
topping_name varchar(255)
ingredient_cost decimal(10,2)

pizza_toppings Example Input:

topping_name ingredient_cost
Pepperoni 0.50
Sausage 0.70
Chicken 0.55
Extra Cheese 0.40

Example Output:

pizza total_cost
Chicken,Pepperoni,Sausage 1.75
Chicken,Extra Cheese,Sausage 1.65
Extra Cheese,Pepperoni,Sausage 1.60
Chicken,Extra Cheese,Pepperoni 1.45

Explanation

There are four different combinations of the three toppings. Cost of the pizza with toppings Chicken, Pepperoni and Sausage is $0.55 + $0.50 + $0.70 = $1.75.

Additionally, they are arranged alphabetically; in the dictionary, the chicken comes before pepperoni and pepperoni comes before sausage.