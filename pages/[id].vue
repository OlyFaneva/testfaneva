<script setup>
definePageMeta({
    layout: "custom",
    middleware: 'auth'
});

const route = useRoute();
let kim = route.params.id;

const { data: productCount } = await useAsyncData("products", () =>
    $fetch(`http://89.116.111.200:8008/api/all/${kim}`)
);

console.log(productCount.content);

const update = async (content) => {
    let kim = route.params.id;
    try {
        const response = await fetch(`http://89.116.111.200:8008/api/updt/${kim}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json' // Ajout des headers nécessaires  
            },
            body: JSON.stringify({
                'content': content
            })
        });

        const data = await response.json();
        refreshNuxtData("products"); // Reste inchangé  
        console.log(data.status.value); // Utilisation de 'data' pour obtenir le status  
    } catch (error) {
        console.error("Error updating data:", error); // Gestion des erreurs  
    }
}  
</script>

<template>
    <div class="relative flex items-top justify-center min-h-screen bg-gray-100 sm:items-center sm:pt-0">
        <div class="w-full">
            <div class="h-100 w-full flex items-center justify-center bg-teal-lightest font-sans">
                <div class="bg-white rounded shadow p-6 m-4 w-full lg:w-3/4 lg:max-w-lg">
                    <div class="mb-4">
                        <h1 class="font-bold text-3xl text-gray-600 text-center">Les modifications</h1>
                        <div class="flex mt-4">
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 mr-4 text-grey-darker"
                                placeholder="Add Todo" v-model="content">
                            <p>{{ productCount.content }}</p>
                            <button
                                class="flex-no-shrink p-2 border-2 rounded-lg text-teal border-teal text-white bg-blue-500 hover:bg-blue-700"
                                @click="update(content)">Update</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>