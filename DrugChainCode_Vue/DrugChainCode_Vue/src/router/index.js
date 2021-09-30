import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '@/components/Login.vue'
import Register from '@/components/Register.vue'
import Main from '@/components/Main.vue'
import Menu from '@/components/Menu.vue'
import Anti_counterfeiting from '@/components/Anti_counterfeiting.vue'
import Trace from '@/components/Trace.vue'
import Warehousing from '@/components/Warehousing.vue'
import Shipment from '@/components/Shipment.vue'
import Warehouse from '@/components/Warehouse.vue'
import Production from '@/components/Production.vue'
import Research_and_development from '@/components/Research_and_development.vue'
import Retail from '@/components/Retail.vue'
// 安装插件
Vue.use(VueRouter)

const router = new VueRouter({
    routes: [
        { path: '', redirect: '/Login' },
        { path: '/Login', component: Login },
        { path: '/Register', component: Register },
        {
            path: '/Main', component: Main, redirect:'/Main/Menu',children: [
                { path: 'Menu', component: Menu},
                { path: 'Anti_counterfeiting', component: Anti_counterfeiting},
                { path: 'Trace', component: Trace},
                { path: 'Warehousing', component: Warehousing},
                { path: 'Shipment', component: Shipment},
                { path: 'Warehouse', component: Warehouse},
                { path: 'Production', component: Production},
                { path: 'Research_and_development', component: Research_and_development},
                { path: 'Retail', component: Retail},
            ]
        },
    ]
})

export default router