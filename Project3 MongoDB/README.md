## Comprehensive MongoDB Project Analysis and Implementation

## Overview

This project is a detailed exploration of MongoDB, focusing on a variety of database operations, in-depth data analysis, and insightful visualization. The primary goal is to demonstrate proficiency in MongoDB and to extract meaningful information, particularly related to movie data. The project covers a wide array of MongoDB functionalities, going beyond basic CRUD operations to delve into more complex data manipulation and analysis techniques. This includes leveraging the aggregation pipeline for sophisticated data transformations, employing various filtering methods to extract very specific subsets of data, and utilizing find operations for both simple and complex data retrieval scenarios. Furthermore, a significant portion of the project is dedicated to the design and implementation of informative visualizations, effectively representing movie-related data and enabling the identification of key trends and patterns. The project aims to provide a robust demonstration of MongoDB's capabilities in a real-world context.

#**Report**
[Click here to view the full Report](https://colab.research.google.com/drive/1zHBHX8i0JSpu-51wR_UYioaKrc9Yw0r2#scrollTo=w7eZPlhjr9v0)

* **CRUD Operations**: Implementation of fundamental database manipulations, including inserting single and multiple documents. This encompasses not only the basic creation of new data entries but also considerations for data integrity, schema design, and efficient data entry strategies.

* **Data Aggregation**: Advanced grouping and analysis of data using the aggregation pipeline to derive complex insights. This involves using multi-stage pipelines to transform raw data into meaningful aggregations, such as averages, sums, and custom metrics. It also demonstrates the ability to handle complex data relationships and perform sophisticated analytical queries.

* **Data Filtering**: Extraction of specific information from the database using various filter techniques. This includes the use of a wide range of query operators to pinpoint data that meets specific criteria, enabling the retrieval of highly relevant and targeted information.

* **Data Retrieval**: Efficiently retrieving data using find operations with sorting and limiting. This covers optimizing query performance, handling large datasets, and presenting data in a user-friendly format.

* **Dashboard Creation**: Designing and implementing visualizations to represent movie-related data, enabling the identification of trends and patterns. This involves selecting appropriate visualization methods, creating interactive dashboards, and effectively communicating data-driven insights. The dashboard serves as a powerful tool for exploring the dataset and uncovering hidden relationships.

## Contributors

* [Rushil Kohli](https://github.com/Rushil-K) 
* [Khushi Kalra](https://github.com/KhushiKalra21)

## License

This project is licensed under the [Apache 2.0 License](https://github.com/Rushil-K/BDMA/blob/main/LICENSE).

## Project Details

The project utilizes the `sample_mflix` database in MongoDB to analyze movie data. The analysis is divided into several key parts:

###   1. CRUD Operations

This section covers the fundamental operations for managing data within MongoDB. It establishes a solid foundation for understanding how data is created, read, updated, and deleted, which are essential skills for any database-driven application.

* **Inserting Data**:

    * Inserting a single movie document using `db.movies.insertOne()`. The example provided inserts a movie titled "Avatar 3". This operation demonstrates the basic syntax for adding a new document to a collection, specifying the field names and their corresponding values.

    * Inserting multiple movie documents using `db.movies.insertMany()`. The example inserts "Interstellar", "Inception", and "The Dark Knight". This showcases a more efficient way to add several documents at once, reducing the number of individual write operations and improving performance.

* **Bulk Inserts**: Demonstrates the process of inserting multiple documents into the `movies` collection, improving efficiency. Bulk inserts are crucial for handling large volumes of data, as they allow for optimized writing and significantly faster data loading.

###   2. Aggregation and Grouping

This section focuses on using MongoDB's aggregation pipeline to group and analyze data. The aggregation pipeline is a powerful tool that allows for multi-stage transformations of data, enabling complex calculations and data manipulations.

* **Counting Movies by Year**:

    * Objective: To determine the number of movies released each year. This analysis provides insights into the historical trends of movie production, revealing which years were the most prolific in terms of film releases.

    * Method: The `$group` stage counts movies by year, and `$sort` arranges the results in descending order to show the most productive years for movie releases. The `$group` stage groups the documents based on the "year" field, and the `$sum` operator counts the number of documents in each group. The `$sort` stage then orders the results, allowing for easy identification of the years with the highest movie output.

* **Finding Average IMDB Rating by Genre**:

    * Objective: To analyze how different genres are rated on average. This analysis helps to understand audience preferences and the critical reception of various film genres.

    * Method: The `$unwind` stage deconstructs the `genres` array, `$group` calculates the average rating for each genre, and `$sort` presents the results in descending order. The `$unwind` stage is essential for dealing with arrays, allowing each genre of a movie to be treated as a separate entry. The `$group` stage then calculates the average IMDB rating for each genre, and the `$sort` stage orders the results, highlighting the genres with the highest average ratings.

* **Calculating Average Runtime by Genre**:

    * Objective: Determine which genres tend to have longer runtimes. This can reveal insights into the storytelling conventions and production styles associated with different genres.

###   3. Filtering Operations

This section details how to use MongoDB to filter data based on specific criteria.

* **Finding Unexpected Audience Hits**:

    * Objective: Identifying movies that were poorly received by critics but highly rated by audiences.

    * Method: Uses `$and` with conditions on `"metacritic"` and `"imdb.rating"`.

* **Identifying Genre-Blending Innovations**:

    * Objective: Finding movies that belong to three or more genres and have high IMDB ratings.

    * Method: Uses `$expr` with `$gte` and `$size` to filter based on the number of genres, along with a condition on `"imdb.rating"`.

* **Finding Potential Licensing Targets**:

    * Objective: Identifying action, fantasy, and sci-fi movies that do not have existing video game adaptations.

    * Method: Uses `$in` to filter genres and `$exists` to check for the absence of the `"video_game"` field.

* **Finding Underutilized Directors**:

    * Objective: Locating directors who have directed a small number of movies but have received high average ratings.

    * Method: Filters based on the size of the `directors` array and the `imdb.rating`.

* **Finding Movies with Global Appeal**:

    * Objective: Identifying movies produced in multiple countries with high ratings

    * Method: Uses `$expr` with `$gt` and `$size` to filter movies based on the number of countries and their IMDB ratings.

###   4. Find Operations

This section covers basic and advanced find operations.

* **Finding the First 5 Movies Sorted by Year**:

    * Objective: Retrieving the latest movies based on their release year.

    * Method: Uses `db.movies.find()`, `sort()` to sort by `"year"` in descending order, and `limit(5)` to retrieve the top 5.

* **Finding Highly-Rated Movies with Specific Keywords**:

    * Objective: Demonstrates using text search.

###   5. Movies Dashboard Visuals

This section describes the visualizations created to analyze the movie data.

* **Genre Performance Metrics**:

    * Type: Stacked Bar Chart.

    * Goal: To visualize the most popular genres and their average IMDB ratings.

    * Setup: X-axis represents genres, Y-axis represents the number of movies, and the bars are stacked by average IMDB rating.

* **Director Success Patterns**:

    * Type: Bubble Chart.

    * Goal: To identify successful directors based on the number of movies they directed and their average ratings.

    * Setup: X-axis represents the total number of movies directed, Y-axis represents the average IMDB rating, and bubble size represents average award wins/nominations. A filter is applied to only show directors with more than 3 movies.

* **Release Timing Impact**:

    * Type: Heatmap.

    * Goal: To determine which months are most favorable for releasing movies in specific genres.

    * Setup: X-axis represents the month of release, Y-axis represents the genre, and color gradient represents the average IMDB rating.

* **Additional Visualizations**:

    * Metacritic score by country.

    * Top 10 languages by number of movies.

    * Genre performance analysis.

    * Director success analysis.

    * Movie release timing analysis.

    * Decade-wise genre evolution.

    * Monthly insights into top-performing release windows.

    * Correlation between runtime and IMDB rating.

    * Award analysis.

    * User engagement trends (annual sum of Mflix comments).

###   6. Dashboard Implementation

* Analysis of movie ratings and releases.

* Key metrics: Number of movies, average Metacritic score.

* Top 10 languages by the number of movies.

* Movie ratings and genre performance analysis.

## Project Structure

The project includes the following files:

* `CRUD Queries.pdf`: Details on basic CRUD operations.

* `kkrk2127_MongoDB_Aggregation_Grouping.pdf`: Details on data aggregation and grouping.

* `kkrk2127_MongoDB_Filter.pdf`: Details on filtering operations.

* `kkrk2127_MongoDB_Find.pdf`: Details on find operations.

* `kkrk2127_Movies_Dashboard.pdf`: Visualizations of movie data.

* `kkrk2127_Movies_Dashboard_MongoDB.pdf`: Analysis of movie ratings and releases.

## Conclusion

This project provides a comprehensive analysis of movie data using MongoDB, demonstrating a wide range of operations and visualization techniques. The insights gained offer value in understanding movie trends, director success factors, and genre performance.

