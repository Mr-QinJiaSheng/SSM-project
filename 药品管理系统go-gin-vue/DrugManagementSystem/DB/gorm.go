package DB

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)
var DB *gorm.DB
var err error
func init() {
	DB,err = gorm.Open("mysql", "root:123456@tcp(106.12.56.151:3306)/drug_management_system?charset=utf8&parseTime=True&loc=Local")
	DB.SingularTable(true)
}

func GetOrm()(db *gorm.DB,err error){
	return DB,err
}
