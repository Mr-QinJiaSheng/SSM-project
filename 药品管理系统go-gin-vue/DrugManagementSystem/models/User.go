package models

type UserAccount struct {
	UID   int    `gorm:"column:UID"`
	Uname string `gorm:"column:Uname"`
	Upwd  string `gorm:"column:Upwd"`
}

type Drug struct {
	DrugCode          string `json:"DrugCode" gorm:"column:DrugCode"`                   //药物链码（日期+单号）
	DrugID            int    `json:"DrugID" gorm:"column:DrugID"`                       //药物ID
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
type DrugType struct {
	DrugID          int    `json:"DrugID" gorm:"column:DrugID"`                   //
	DrugName        string `json:"DrugName" gorm:"column:DrugName"`               //药品名称
	DrugComposition string `json:"DrugComposition" gorm:"column:DrugComposition"` //药物成分
	UsageMethod     string `json:"UsageMethod" gorm:"column:UsageMethod"`         //使用方法
	MainFunction    string `json:"MainFunction" gorm:"column:MainFunction"`       //主治功能
}
type UserInformation struct {
	UID            int    `json:"UID" gorm:"column:UID"`                       //
	CompanyName    string `json:"CompanyName" gorm:"column:CompanyName"`       //公司名称
	Director       string `json:"Director" gorm:"column:Director"`             //公司负责人
	Address        string `json:"Address" gorm:"column:Address"`               //公司地址
	CompanyProfile string `json:"CompanyProfile" gorm:"column:CompanyProfile"` //公司简介
	PhoneNUM       string `json:"PhoneNUM" gorm:"column:PhoneNUM"`             //公司电话
	Power          int    `json:"Power" gorm:"column:Power"`                   //权限（1-生产商，2-经销商）
}
type VerificationCode struct {
	VerificationCode string `json:"VerificationCode" gorm:"column:VerificationCode"` //验证码内容
}

type UserJurisdiction struct {
	ClassName    string `json:"ClassName" gorm:"column:ClassName"`       //
	ImgSrc       string `json:"ImgSrc" gorm:"column:ImgSrc"`             //
	Jurisdiction int    `json:"Jurisdiction" gorm:"column:Jurisdiction"` //
	Name         string `json:"Name" gorm:"column:Name"`                 //
}

type Response struct {
	Code int         `json:"Code"`
	Data interface{} `json:"data"`
}
