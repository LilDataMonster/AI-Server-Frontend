<template>
  <v-app id="inspire">
    <v-app-bar
      app
      color="white"
      flat
    >
      <v-avatar
        :color="$vuetify.breakpoint.smAndDown ? 'grey darken-1' : 'transparent'"
        size="32"
      ></v-avatar>

      <v-tabs
        centered
        class="ml-n9"
        color="grey darken-1"
      >
        <v-tab
          v-for="link in links"
          :key="link"
        >
          {{ link }}
        </v-tab>
      </v-tabs>

      <v-avatar
        class="hidden-sm-and-down"
        color="grey darken-1 shrink"
        size="32"
      ></v-avatar>
    </v-app-bar>

    <v-main class="grey lighten-3">
      <v-container>
        <v-row>
          <v-col
            cols="12"
            sm="3"
          >
            <v-sheet
              rounded="lg"
              min-height="268"
            >
              <!--  -->
              <WeatherCard />
            </v-sheet>
          </v-col>

          <v-col
            cols="12"
            sm="6"
          >
            <!-- <v-sheet
              min-height="70vh"
              rounded="lg"
            > -->
            <v-sheet
              min-height="50vh"
              rounded="lg"
            >
              <!--  -->
              <FilterTable />
            </v-sheet>
          </v-col>

          <v-col
            cols="12"
            sm="3"
          >
            <v-sheet
              rounded="lg"
              min-height="268"
            >
              <!--  -->
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
  import FilterTable from '@/components/FilterTable.vue'
  import WeatherCard from '@/components/cards/WeatherCard.vue'

  export default {
    data: () => ({
      links: [
        'Dashboard',
        'Messages',
        'Profile',
        'Updates',
      ],
    }),
    components: {
      FilterTable,
      WeatherCard
    }
  }
</script>
