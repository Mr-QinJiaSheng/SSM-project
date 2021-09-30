package main

import (
	"DrugManagementSystem/middleware"
	"DrugManagementSystem/router"
	"fmt"
	"github.com/gin-gonic/gin"
)

func main(){
	r := gin.Default()
	//使用中间件
	r.Use(middleware.Cors())
	router.UserAccount(r)

	if err := r.Run(":8002"); err != nil {
		fmt.Printf("startup service failed, err:%v\n\n", err)
	}
}
