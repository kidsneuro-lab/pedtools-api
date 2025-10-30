FROM opencpu/base:latest
ENV CRAN_REPO=https://cloud.r-project.org
RUN R -e "install.packages('pedtools')"
EXPOSE 8004
