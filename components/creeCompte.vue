<template>
    <div class="relative flex items-top justify-center min-h-screen bg-gray-100 sm:items-center sm:pt-0">
        <div class="w-full">
            <div class="h-100 w-full flex items-center justify-center bg-teal-lightest font-sans">
                <div class="bg-white rounded shadow p-6 m-4 w-full lg:w-3/4 lg:max-w-lg">
                    <div class="mb-4">
                        <h1 class="font-bold text-3xl text-gray-600 text-center">Simple creation de compte</h1>
                        <div class="flex mt-4">
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                                placeholder="Email" v-model="email">
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                                placeholder="Name" v-model="name">
                            <input type="password"
                                class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                                placeholder="Password" v-model="pass">
                            <input type="password"
                                class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                                placeholder="Confirm Password" v-model="coPass">
                        </div>
                    </div>
                    <div>
                        <div class="flex mb-4 items-center">
                            <p class="w-full text-grey-darkest font-semibold text-gray-600"></p>
                            <button
                                class="flex-no-shrink p-2 ml-2 border-2 rounded-lg text-red border-red text-white bg-red-500 hover:bg-red-700"
                                @click="create">Sign Up</button>
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
            name: "",
            coPass: "",
            pass: "",
        }
    },
    methods: {
        async create() {
            if (this.coPass !== this.pass) {
                console.log("Passwords do not match");
                return; // exit the method if passwords don't match  
            }

            try {
                const response = await fetch('http://89.116.111.200:8008/api/registration', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json' // specify the content type  
                    },
                    body: JSON.stringify({ // convert the body to JSON  
                        email: this.email,
                        name: this.name,
                        password: this.pass,
                    })
                });

                const data = await response.json(); // parse the JSON response  
                console.log(data.message); // log the response data

                if (data.message == "you're connected") {
                    return navigateTo('/')
                }
                console.log(data.message);



                // if (response.ok && data.status === "success") {
                //     console.log("Registration successful");
                //     this.$router.push('/'); // assuming you're using Vue Router for navigation  
                // } else {
                //     console.log("Registration failed:", data.message);
                // }

            } catch (error) {
                console.error("Error:", error); // handle errors  
            }
        }
    }
}  
</script>