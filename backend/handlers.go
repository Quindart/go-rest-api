package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func getUsers(c *gin.Context) {
	log.Printf("GET /users from %s", c.ClientIP())
	c.IndentedJSON(http.StatusOK, Users)
}

func createUser(c *gin.Context) {
	log.Printf("POST /users from %s", c.ClientIP())
	var newUser User
	if err := c.BindJSON(&newUser); err != nil {
		log.Printf("POST /users invalid payload: %v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	Users = append(Users, newUser)
	log.Printf("POST /users created user id=%s total_users=%d", newUser.ID, len(Users))
	c.IndentedJSON(http.StatusCreated, newUser)
}