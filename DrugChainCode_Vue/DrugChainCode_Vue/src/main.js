import Vue from 'vue'
import App from './App.vue'
import router from '@/router/index.js'

import Head_navigation_bar from '@/components/Head_navigation_bar.vue'


Vue.component('HeadNavigationBar',Head_navigation_bar)

Vue.config.productionTip = false

new Vue({
  
  render: h => h(App),
  router
}).$mount('#app')
