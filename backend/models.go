package main

type User struct {
	ID    string `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
	Age   int    `json:"age"`
}

var Users = []User{
	{
		ID:    "1",
		Name:  "Le Minh Wuang",
		Email: "leminhwuang@example.com",
		Age:   30,
	},
	{
		ID:    "2",
		Name:  "John Doe",
		Email: "johndoe@example.com",
		Age:   25,
	},
}
