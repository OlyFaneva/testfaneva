<script setup>

definePageMeta({
    layout: "afficher" , 
    middleware: 'auth'
});

</script>

<template>
    <div>
        <todo />
    </div>
</template>