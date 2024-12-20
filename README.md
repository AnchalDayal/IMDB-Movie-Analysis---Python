# IMDB Movie Analysis  

## Objective  
As a data analyst intern at IMDB, you will explore and analyze a dataset of movies to uncover insights into movie trends, genre popularity, and factors influencing movie success. This project leverages Python and libraries like Pandas, NumPy, Seaborn, and Matplotlib to perform a detailed analysis.  

## Dataset Overview  
The dataset includes the following columns:  
- **`names`**: Movie titles  
- **`date_x`**: Release dates  
- **`score`**: IMDB ratings  
- **`genre`**: Genres  
- **`overview`**: Movie summaries  
- **`crew`**: Cast and crew information  
- **`orig_title`**: Original titles  
- **`status`**: Release status (e.g., released, post-production)  
- **`orig_lang`**: Original language  
- **`budget_x`**: Production budgets  
- **`revenue`**: Box office revenues  
- **`country`**: Production country  

## Analysis Tasks and Questions  

### 1. Project Setup and Data Loading  
 - What libraries are required for this project, and why are they useful in data analysis?
 - Load the dataset. What is the shape of the dataset? What does each row and column represent? 

### 2. Data Overview and Basic Exploration  
- Use .info() to understand the data types and missing values. What potential issues can you spot?
- Describe the main characteristics of each column using .describe(). What can you infer from the mean, median, and distribution of numerical columns?

### 3. Data Cleaning  
- Which columns contain missing values? How would you handle them?
- Are there any columns where data types need conversion (e.g., date, ratings)? Explain your decision.

### 4. Univariate Analysis  
- Analyze the distribution of IMDB ratings (`score`) using a histogram and describe its shape
- What are the most common genres in the dataset? Use a bar chart to show their distribution.


### 5. Bivariate Analysis  
- Explore the relationship between `budget_x` and `revenue` using a scatter plot.  
- Compare IMDB ratings (`score`) across Country using a boxplot.  
- Is there a correlation between the number of votes a movie received and its rating? Create a scatter plot and calculate the correlation coefficient. What can you conclude? 


### 6. Genre-Specific Analysis  
- Which genre has the highest average rating? Calculate the average rating for each genre and plot the results.
- How does the popularity of genres vary over time? Plot the number of movies released per genre each year.
- Compare budgets and revenues for specific genres.

### 7. Year and Trend Analysis  
- How has the average movie rating changed over the years? Plot the average rating for each year.  
- Which years had the highest and lowest number of movie releases? Plot the number of movies released each year
- Do certain years show a higher average budget? Analyze the average budget by year and observe any trends.

Do certain years show a higher average runtime? Analyze the average runtime by year and observe any trends.

### 8. Multivariate Analysis  
- Identify the most popular genres in each country using grouped bar charts.  
- Analyze the influence of `budget_x`, `genre`, and `country` on revenues using a heatmap. 
   
### 9. Insights and Summary  
- Summarize three major insights from the analysis regarding movie trends, genre popularity, and factors affecting movie success.  
- Propose additional questions or datasets that could enhance the analysis.  

## Additional Questions Based on Dataset  
- Which countries produce the highest-rated movies on average?  
- Does the original language (`orig_lang`) correlate with ratings?  
- How does `status` (e.g., released, post-production) influence ratings or revenues?  

## Tools and Libraries Used  
- **Python**  
- **Pandas**: Data manipulation and analysis  
- **NumPy**: Numerical computations  
- **Matplotlib**: Data visualization  
- **Seaborn**: Advanced visualization  

## Getting Started  
1. Clone the repository:  
   ```bash  
   git clone https://github.com/AnchalDayal/IMDB-Movie-Analysis---Python.git  
