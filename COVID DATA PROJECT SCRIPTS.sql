--COVID DEATHS

Select *
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 3,4


--Select *
--From PortfolioProject..CovidVaccinations
--Order by 3,4


Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 1,2


--Looking at Total Cases vs Total Deaths
--Estimated Chances of Death if contracted by Covid in India
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location='India'
Order by 1,2


--Looking at Total Cases VS Population
--Shows Percentage of Population Infected by covid
Select location, date, population, total_cases, (total_cases/population)*100 as InfectedPercentage
From PortfolioProject..CovidDeaths
Where location='India'
Order by 1,2


--Countries with Highest Infection Rate
Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as MaxInfectedPercentage
From PortfolioProject..CovidDeaths
Group by location, population
Order by MaxInfectedPercentage desc


--Countries with Highest Death Rate
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by location
Order by TotalDeathCount desc


--BY CONTINENT


-- Showing the Continent with the Highest Death Count
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
Order by TotalDeathCount desc


--Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
--From PortfolioProject..CovidDeaths
--Where continent is null
--Group by location
--Order by TotalDeathCount desc


--GLOBAL NUMBERS

Select date, SUM(new_cases) as Daily_New_Cases, SUM(cast(new_deaths as int)) as Daily_New_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases) * 100 as DailyDeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group by date
Order by 1,2


--COVID VACCINATION

--Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as TotalVaccTillDate
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location=vac.location
	and dea.date=vac.date
Where dea.continent is not null
Order by 2,3

--USE CTE
With PopVsVacc (Continent, Location, Date, Population, New_Vaccinations, TotalVaccTillDate)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as TotalVaccTillDate
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location=vac.location
	and dea.date=vac.date
Where dea.continent is not null
--Order by 2,3
)
Select *, (TotalVaccTillDate/Population)*100 as PercVaccTillDate
From PopVsVacc

--TEMP TABLE

DROP Table if EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
TotalVaccTillDate numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as TotalVaccTillDate
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location=vac.location
	and dea.date=vac.date
Where dea.continent is not null
--Order by 2,3

Select *, (TotalVaccTillDate/Population)*100 as PercVaccTillDate
From #PercentPopulationVaccinated


--Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as TotalVaccTillDate
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location=vac.location
	and dea.date=vac.date
Where dea.continent is not null
--Order by 2,3


Select *
From PercentPopulationVaccinated