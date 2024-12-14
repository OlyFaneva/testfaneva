<script setup>
    const { data: productCount } = await useAsyncData("products" ,() =>  
    $fetch("http://89.116.111.200:8008/api/all")
     );
// Ajout avec fecth
    //  const submit = () =>  {
    //   $fetch("http://89.116.111.200:8008/api/store" , {
    //     method: 'POST' ,
    //     body: {
    //       'content' : 'je vien du js sama'
    //     }
    //   })
    //  }


    const refresh = () => refreshNuxtData("products")
// Remove
const remove = (id) => {
  useFetch(`http://89.116.111.200:8008/api/suppr/${id}`, {
    method: 'DELETE'
  }).then((res) => {
    refresh();
    console.log(res.status.value)
  })
}



//  Ajout avec useFetch
function submit(donne){
  const { data, pending, error, refresh } =  useFetch('http://89.116.111.200:8008/api/store',{
      method : 'POST' , 
      body : {
        'content' : donne
      }
    }).then((res) =>{
      this.karim = ""
      refreshNuxtData("products")
      console.log(res.status.value)
      
    })      
}






</script>
<!-- Please remove this file from your project -->
<template>
        <!-- <li v-for="item in productCount" :key="item.id">{{ item.content }}</li> -->

  <div class="relative flex items-top justify-center min-h-screen bg-gray-100 sm:items-center sm:pt-0">
    <div class="w-full">
      <!-- component -->
      <div class="h-100 w-full flex items-center justify-center bg-teal-lightest font-sans">
        <div class="bg-white rounded shadow p-6 m-4 w-full lg:w-3/4 lg:max-w-lg">
          <div class="mb-4">
            <h1 class="font-bold text-3xl text-gray-600 text-center">Todo List</h1>
            <div class="flex mt-4">

              <input class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                placeholder="Add Todo" v-model="karim">
              <button
                class="flex-no-shrink p-2 border-2 rounded-lg text-teal border-teal text-white bg-blue-500 hover:bg-blue-700"
                @click="submit(karim)">Add</button>
            </div>
          </div>
          <div>

                  <div v-for="item in productCount" :key="item.id" class="flex mb-4 items-center">
                      <p class="w-full text-grey-darkest font-semibold text-gray-600"> {{ item.content }} </p>
                      <NuxtLink class="flex-no-shrink w-1/3 p-2 ml-4 mr-2 border-2 rounded-lg border-grey  bg-green-400" :to="`/${item.id}`" > Custom</NuxtLink>
                      <button class="flex-no-shrink p-2 ml-2 border-2 rounded-lg text-red border-red text-white bg-red-500 hover:bg-red-700" @click="remove(item.id)">Remove</button>
                  </div>
              </div>
        </div>
      </div>

    </div>
  </div>
</template>
  