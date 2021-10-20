<template>
  <v-card>
  <!-- tesst{{allLegoColor}} -->
    <v-card-title>
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        single-line
        hide-details
      ></v-text-field>
    </v-card-title>
    <v-data-table
      :headers="headers"
      :items="allLegoColor"
      :search="search"
    ></v-data-table>
  </v-card>
</template>

<script>
  import gql from 'graphql-tag'

  export default {
    data () {
      return {
        search: '',
        headers: [
          {
            text: 'Name',
            align: 'start',
            // filterable: false,
            value: 'name',
          },
          { text: 'Material', value: 'material' },
          { text: 'Hex Color', value: 'hexCode' },
        ],
      }
    },
    apollo: {
      allLegoColor: {
        query:gql`
          query {
            allLegoColor{
              edges{
                node{
                  name
                  material
                  blColorName
                  ldrawColorId
                  hexCode
                }
              }
            }
          }`,
        update: function(data) {
          return data.allLegoColor.edges.map(function(edge) {
            return edge.node;
          });
        }

      }
    },
  }
</script>
