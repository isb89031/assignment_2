setwd("~/Desktop/Year2/ST2195, Programming/st2195_assignment_2/r_csv")

library(rvest)

# Read html format from website
html <- read_html("https://en.wikipedia.org/wiki/Comma-separated_values")
html
class(html)


# Pipe html to node to table
# Get xpath using inspect function on website

# Scrape the table format version (1st interpretation)

# Both the XPaths below should work
# //*[@id="mw-content-text"]/div[1]/table[2]/tbody
# //*[@id="mw-content-text"]/div[1]/table[2]

csv_table <- html %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div[1]/table[2]') %>%
  html_table()
csv_table

csv_table2 <- html %>%
  #html_nodes("table") %>%  #superceded by html_elements()
  html_elements("table") %>%
  html_table()
csv_table2
csv_table2[[2]]

csv_table3 <- html %>%
  html_elements("tbody") %>%
  html_table()
csv_table3
csv_table3[[2]]

#csv_table3 <- html %>%
#  html_elements(css="tbody") %>%
#  html_text()
#csv_table3


# Scrape the CSV format version (2nd interpretation)
#//*[@id="mw-content-text"]/div[1]/pre[1]
#//*[@id="mw-content-text"]/div[1]/pre[1]/text()

csv_table_alt <- html %>%
  html_elements(xpath='//*[@id="mw-content-text"]/div[1]/pre[1]/text()') %>%
  html_text()
csv_table_alt

help(html_nodes)
help(html_element)
#help(html_table)
#help(html_text)

# write to csv file
write.csv(csv_table, file = "car.csv", row.names = FALSE)
write.table(csv_table_alt, file = "car_alt.csv", quote = FALSE, col.names = FALSE, row.names = FALSE)

# Read csv file to verify
df1=read.csv("car.csv")
class(df1)
str(df1)

df2=read.csv("car_alt.csv")
class(df2)
str(df2)
