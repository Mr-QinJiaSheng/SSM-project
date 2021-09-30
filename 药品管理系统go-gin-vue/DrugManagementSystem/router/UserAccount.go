package router

import (
	"DrugManagementSystem/DB"
	"DrugManagementSystem/models"
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"strconv"
	"time"
)

func UserAccount(e *gin.Engine) {
	//登入
	e.POST("/Login", Login)
	//注册
	e.POST("/Register", Register)
	//获取功能模块
	e.GET("/getFunctionalModule", getFunctionalModule)
	//添加药物种类
	e.POST("/addDrugType", AddDrugType)
	//获取药物种类
	e.GET("/getDrugType", GetDrugType)
	//生产入库
	e.POST("/productionDrug", ProductionDrug)
	//获取仓库信息
	e.GET("/getWarehouseInformation", getWarehouseInformation)
	//获取仓库中可发货的信息
	e.GET("/getShipmentInformation", getShipmentInformation)
	//获取收件方信息
	e.GET("/getReceive", getReceive)
	//发货
	e.POST("/Shipment", Shipment)
	//获取仓库中可收货信息
	e.GET("/getWarehousingInformation", getWarehousingInformation)
	//收货
	e.POST("/Warehousing", Warehousing)
	//防伪查询
	e.GET("/getAnti_counterfeitingInformation", getAntiCounterfeitingInformation)
}

func Warehousing(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}

	//获取post请求参数
	DrugCode := context.PostForm("DrugCode")
	Owner:=context.PostForm("Owner")
	OwnerID:=context.PostForm("OwnerID")

	fmt.Println(DrugCode,Owner,OwnerID)
	//编写sql语句
	sql:="update drug set Owner=?,OwnerID=?,OptStatus=1,TradingTime=?,ShipmentNUM='',Receive=null,ReceiveID=null where DrugCode=?"
	//设置交易时间
	TradingTime := time.Now().Format("2006-01-02 15-04-05")

	result := DB.Exec(sql, Owner, OwnerID, TradingTime, DrugCode)
	if result.Error != nil {
		OK(context, 0, result.Error.Error())
		return
	}

	OK(context, 200, "收货成功")
}

func getReceive(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}

	//获取post请求参数
	UIDString := context.Query("UID")

	UID, _ := strconv.Atoi(UIDString)
	//编写sql语句
	sql := "select * from user_information where UID!=?"

	var userInformation []models.UserInformation
	DB.Raw(sql, UID).Scan(&userInformation)

	if userInformation == nil {
		OK(context, 0, "网络错误，请稍后尝试")
		return
	}
	OK(context, 200, userInformation)
}

func Shipment(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}

	//获取post请求参数
	DrugCode := context.PostForm("DrugCode")
	ReceiveIDString := context.PostForm("ReceiveID")
	DrugIDString := context.PostForm("DrugID")

	ReceiveID, _ := strconv.Atoi(ReceiveIDString)

	//编写sql语句,通过ReceiveID去寻找Receive
	sql := "select CompanyName from user_information where UID=?"
	var userInformation models.UserInformation
	DB.Raw(sql, ReceiveID).Scan(&userInformation)
	Receive := userInformation.CompanyName

	//修改药物的信息
	sql = "update drug set Receive=?,ReceiveID=?,OptStatus=2,TradingTime=?,ShipmentNUM=? where DrugCode=?"
	//设置交易单号
	ShipmentNUM := "DS" + DrugIDString + time.Now().Format("20060102150405")
	//设置交易时间
	TradingTime := time.Now().Format("2006-01-02 15-04-05")
	//执行sql语句
	result := DB.Exec(sql, Receive, ReceiveID, TradingTime, ShipmentNUM, DrugCode)
	if result.Error != nil {
		OK(context, 0, result.Error.Error())
		return
	}

	OK(context, 200, "发货成功")

}
func getAntiCounterfeitingInformation(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}
	//前端需要的指定数据
	type AntiCounterfeitingInformation struct {
		DrugName          string `json:"DrugName" gorm:"column:DrugName"`                   //药品名称
		Owner             string `json:"Owner" gorm:"column:Owner"`                         //药品持有者
		OwnerID           int    `json:"OwnerID" gorm:"column:OwnerID"`                     //药品持有者ID
		ShipmentNUM       string `json:"ShipmentNUM" gorm:"column:ShipmentNUM"`             //交易单号（日期+单号）
		Receive           string `json:"Receive" gorm:"column:Receive"`                     //药品收货方
		ReceiveID         int    `json:"ReceiveID" gorm:"column:ReceiveID"`                 //药品收货方ID
		ProductionDate    string `json:"ProductionDate" gorm:"column:ProductionDate"`       //药品生产日期
		OptStatus         int    `json:"OptStatus" gorm:"column:OptStatus"`                 //药物状态（1-在库，2-交易，3-售出）
		TradingTime       string `json:"TradingTime" gorm:"column:TradingTime"`             //交易日期
		ProductionCompany string `json:"ProductionCompany" gorm:"column:ProductionCompany"` //生产公司
	}
	//获取get请求参数
	DrugCode := context.Query("DrugCode")

	//编写sql语句
	sql := "select drug_type.DrugName," +
		"drug.Owner,drug.OwnerID,drug.ShipmentNUM," +
		"drug.Receive,drug.ReceiveID,drug.ProductionDate," +
		"drug.OptStatus,drug.TradingTime,drug.ProductionCompany " +
		"from drug inner JOIN drug_type on drug.DrugID=drug_type.DrugID " +
		"where drug.DrugCode=? "

	var antiCounterfeitingInformation AntiCounterfeitingInformation
	//执行sql
	DB.Raw(sql, DrugCode).Scan(&antiCounterfeitingInformation)
	if len(antiCounterfeitingInformation.DrugName) == 0 {
		OK(context, 0, "未查到该药物信息，请及时与销售商联系，或拨打12315及时维护自生权益")
		return
	}
	OK(context, 200, antiCounterfeitingInformation)
}
func getWarehousingInformation(context *gin.Context) {
	//获取get请求参数
	ReceiveID := context.Query("ReceiveID")
	sql := "select drug.DrugCode,drug_type.DrugName,drug_type.DrugID,drug.ProductionDate,drug.OptStatus,drug.ProductionCompany " +
		"from drug inner JOIN drug_type on drug.DrugID=drug_type.DrugID " +
		"where drug.ReceiveID=" + ReceiveID + " and drug.OptStatus=2"
	GetDrugInformation(sql, context)
}

func getShipmentInformation(context *gin.Context) {
	//获取get请求参数
	OwnerID := context.Query("OwnerID")
	//编写sql语句
	sql := "select drug.DrugCode,drug_type.DrugName,drug_type.DrugID,drug.ProductionDate,drug.OptStatus,drug.ProductionCompany " +
		"from drug inner JOIN drug_type on drug.DrugID=drug_type.DrugID " +
		"where drug.OwnerID=" + OwnerID + " and drug.OptStatus=1"

	GetDrugInformation(sql, context)
}

func getWarehouseInformation(context *gin.Context) {
	//获取get请求参数
	OwnerID := context.Query("OwnerID")
	//编写sql语句
	sql := "select drug.DrugCode,drug_type.DrugName,drug_type.DrugID,drug.ProductionDate,drug.OptStatus,drug.ProductionCompany " +
		"from drug inner JOIN drug_type on drug.DrugID=drug_type.DrugID " +
		"where drug.OwnerID=" + OwnerID + " and drug.OptStatus in(1,2)"

	GetDrugInformation(sql, context)
}

func GetDrugInformation(sql string, context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}
	//前端需要的指定数据
	type WarehouseData struct {
		DrugCode          string `json:"DrugCode" gorm:"column:DrugCode"`
		DrugID            int    `json:"DrugID" gorm:"column:DrugID"`
		DrugName          string `json:"DrugName" gorm:"column:DrugName"`
		ProductionDate    string `json:"ProductionDate" gorm:"column:ProductionDate"`
		OptStatus         int    `json:"OptStatus" gorm:"column:OptStatus"`
		ProductionCompany string `json:"ProductionCompany" gorm:"column:ProductionCompany"`
	}

	var warehouseDates []WarehouseData
	//执行sql
	DB.Raw(sql).Scan(&warehouseDates)
	if warehouseDates == nil {
		OK(context, 0, "网络异常，请重试")
		return
	}

	//获取页数
	page := len(warehouseDates) / 10
	//最后一页中的行数
	lastPage := 0
	//若不能被页数完整装下，就而外增加一页，并设置最后一页的行数
	if len(warehouseDates)%10 != 0 {
		//页数加一
		page++
		//设置最后一页中的行数
		lastPage = len(warehouseDates) % 10
	}
	//切片，将数据放入每一页
	var warehouseDateJSON [99][10]WarehouseData
	for i := 0; i < page; i++ {
		//判断是否在最后一页
		if (i != page-1) || (lastPage == 0) {
			//分页
			for num, warehouseDate := range warehouseDates[(i * 10):((i + 1) * 10)] {
				warehouseDateJSON[i][num] = warehouseDate
			}
		} else {
			for num, warehouseDate := range warehouseDates[(i * 10) : (i*10)+lastPage] {
				warehouseDateJSON[i][num] = warehouseDate
			}
		}
	}

	OK(context, 200, warehouseDateJSON[:page])
}

func ProductionDrug(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}

	//获取post请求参数
	DrugIDString := context.PostForm("DrugID")
	ProductionDate := context.PostForm("ProductionDate")
	Udata := context.PostForm("Udata")

	DrugID, _ := strconv.Atoi(DrugIDString)
	//获取公司信息
	var user_information models.UserInformation
	err = json.Unmarshal([]byte(Udata), &user_information)

	//设置药物的身份码
	DrugCode := "DC" + DrugIDString + time.Now().Format("20060102150405")

	sql := "insert into drug(DrugCode,DrugID,Owner,OwnerID,ProductionDate,OptStatus,ProductionCompany) values(?,?,?,?,?,?,?)"
	result := DB.Exec(sql, DrugCode, DrugID, user_information.CompanyName, user_information.UID, ProductionDate, 1, user_information.CompanyName)
	if result.Error != nil {
		OK(context, 0, result.Error.Error())
		return
	}
	OK(context, 200, "成功")
}

func GetDrugType(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}

	sql := "select * from drug_type "
	var DrugType []models.DrugType
	DB.Raw(sql).Scan(&DrugType)

	if DrugType == nil {
		OK(context, 200, "网络异常，请重试")
		return
	}

	OK(context, 200, &DrugType)

}

func AddDrugType(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}
	//获取post请求参数
	DrugName := context.PostForm("DrugName")
	DrugComposition := context.PostForm("DrugComposition")
	UsageMethod := context.PostForm("UsageMethod")
	MainFunction := context.PostForm("MainFunction")

	//添加进数据库
	sql := "insert into drug_type(DrugName,DrugComposition,UsageMethod,MainFunction) values(?,?,?,?)"
	result := DB.Exec(sql, DrugName, DrugComposition, UsageMethod, MainFunction)
	if result.Error != nil {
		OK(context, 0, result.Error.Error())
		return
	}
	OK(context, 200, "药品种类添加成功")
}

func getFunctionalModule(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}
	//获取get请求参数
	Power := context.Query("Power")

	sql := "select * from user_jurisdiction where jurisdiction in(0,?) "
	var UserJurisdiction []models.UserJurisdiction
	DB.Raw(sql, Power).Scan(&UserJurisdiction)

	if UserJurisdiction == nil {
		OK(context, 200, "网络异常，请重试")
		return
	}

	OK(context, 200, &UserJurisdiction)
}

func Register(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}
	//获取post请求参数
	Uname := context.PostForm("Uname")
	Upwd := context.PostForm("Upwd")
	CompanyName := context.PostForm("CompanyName")
	Director := context.PostForm("Director")
	Address := context.PostForm("Address")
	PhoneNUM := context.PostForm("PhoneNUM")
	Power := context.PostForm("Power")

	//判断此账号是否已存在
	sql := "select * from user_account where Uname=? "
	var userAccount models.UserAccount
	DB.Raw(sql, Uname).Scan(&userAccount)
	//若在数据库中找到了账号记录，不给予注册
	if userAccount.UID != 0 {
		OK(context, 0, "用户名已存在")
		return
	}

	//注册账号
	sql = "insert into user_account(Uname,Upwd) values(?,?)"
	result := DB.Exec(sql, Uname, Upwd)
	if result.Error != nil {
		OK(context, 0, result.Error.Error())
		return
	}
	//将注册成功的账号返回浏览器
	sql = "select * from user_account where Uname=? "
	DB.Raw(sql, Uname).Scan(&userAccount)
	//补充账号完整信息
	sql = "insert into user_information(UID,CompanyName,Director,Address,PhoneNUM,Power) values(?,?,?,?,?,?)"
	result = DB.Exec(sql, userAccount.UID, CompanyName, Director, Address, PhoneNUM, Power)
	if result.Error != nil {
		sql = "delete from user_account where UID=?"
		result = DB.Exec(sql, userAccount.UID)
		if result.Error != nil {
			OK(context, 0, result.Error.Error())
			return
		}

		OK(context, 0, result.Error.Error())
		return
	}

	OK(context, 200, &userAccount)
}

func Login(context *gin.Context) {
	//获取DB
	DB, err := DB.GetOrm()
	if err != nil {
		OK(context, 0, err.Error())
		return
	}
	//获取post请求参数
	Uname := context.PostForm("Uname")
	Upwd := context.PostForm("Upwd")
	//判断账号信息是否无误
	sql := "select * from user_account where Uname=? and Upwd=?"
	var userAccount models.UserAccount
	DB.Raw(sql, Uname, Upwd).Scan(&userAccount)
	if userAccount.UID != 0 {
		sql = "select * from user_information where UID=?"
		var userInformation models.UserInformation
		DB.Raw(sql, userAccount.UID).Scan(&userInformation)
		OK(context, 200, &userInformation)
	} else {
		OK(context, 0, "账号或密码错误")
	}
}

//将信息打包并返回
func OK(context *gin.Context, code int, data interface{}) {
	response := models.Response{
		Code: code,
		Data: data,
	}
	context.JSON(200, &response)
}
