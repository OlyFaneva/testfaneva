<script setup>
definePageMeta({
    layout: 'default'
})
</script>

<template>
    <!-- <li v-for="item in productCount" :key="item.id">{{ item.content }}</li> -->

    <div class="relative flex items-top justify-center min-h-screen bg-gray-100 sm:items-center sm:pt-0">
        <div class="w-full">
            <!-- component -->
            <div class="h-100 w-full flex items-center justify-center bg-teal-lightest font-sans">
                <div class="bg-white rounded shadow p-6 m-4 w-full lg:w-3/4 lg:max-w-lg">
                    <div class="mb-4">
                        <h1 class="font-bold text-3xl text-gray-600 text-center">Login</h1>
                        <div class="flex mt-4">

                            <input class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                                placeholder="Email" v-model="email">
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                                placeholder="Password" v-model="pass">
                        </div>
                    </div>
                    <div>
                        <div class="flex mb-4 items-center">

                            <p class="w-full text-grey-darkest font-semibold text-gray-600"></p>
                            <button @click="submit()"
                                class="flex-no-shrink p-2 ml-2 border-2 rounded-lg text-red border-red text-white bg-red-500 hover:bg-red-700">connexion</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</template>

<script>

export default {
    data() {
        return {
            email: "",
            pass: ""
        }
    },
    methods: {
        submit() {
            const { data } = useFetch('http://89.116.111.200:8008/api/login', {
                method: 'POST',
                body: {
                    'email': this.email,
                    'password': this.pass
                }
            }).then((res) => {
                localStorage.setItem('token', res.data.value.token);
                console.log(res)
                if (res.status.value == "success") {
                    return navigateTo('/afficher')
                }
            })
        }
    }
}

</script>