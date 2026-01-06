#!/bin/bash

# Currency Converter Test Runner Script
# Usage: ./test_runner.sh [option]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Currency Converter Test Runner${NC}"
echo "================================"

# Function to run all tests
run_all_tests() {
    echo -e "\n${YELLOW}Running all tests...${NC}"
    flutter test
}

# Function to run tests with coverage
run_with_coverage() {
    echo -e "\n${YELLOW}Running tests with coverage...${NC}"
    flutter test --coverage
    
    if [ -f "coverage/lcov.info" ]; then
        echo -e "\n${GREEN}Coverage report generated!${NC}"
        echo "To view HTML report:"
        echo "  genhtml coverage/lcov.info -o coverage/html"
        echo "  open coverage/html/index.html"
    fi
}

# Function to run specific feature tests
run_feature_tests() {
    echo -e "\n${YELLOW}Available features:${NC}"
    echo "1. Currency Converter"
    echo "2. Historical Rates"
    echo "3. All Features"
    
    read -p "Select feature (1-3): " feature
    
    case $feature in
        1)
            echo -e "\n${YELLOW}Running Currency Converter tests...${NC}"
            flutter test test/features/currency_converter/
            ;;
        2)
            echo -e "\n${YELLOW}Running Historical Rates tests...${NC}"
            flutter test test/features/historical_rates/
            ;;
        3)
            run_all_tests
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            exit 1
            ;;
    esac
}

# Function to run specific layer tests
run_layer_tests() {
    echo -e "\n${YELLOW}Available layers:${NC}"
    echo "1. Data Layer (API Integration)"
    echo "2. Domain Layer (Business Logic)"
    echo "3. Presentation Layer (State Management)"
    echo "4. Integration Tests"
    
    read -p "Select layer (1-4): " layer
    
    case $layer in
        1)
            echo -e "\n${YELLOW}Running Data Layer tests...${NC}"
            flutter test test/features/*/data/
            ;;
        2)
            echo -e "\n${YELLOW}Running Domain Layer tests...${NC}"
            flutter test test/features/*/domain/
            ;;
        3)
            echo -e "\n${YELLOW}Running Presentation Layer tests...${NC}"
            flutter test test/features/*/presentation/
            ;;
        4)
            echo -e "\n${YELLOW}Running Integration tests...${NC}"
            flutter test test/features/*/integration/
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            exit 1
            ;;
    esac
}

# Main menu
show_menu() {
    echo -e "\n${YELLOW}Select an option:${NC}"
    echo "1. Run all tests"
    echo "2. Run tests with coverage"
    echo "3. Run tests by feature"
    echo "4. Run tests by layer"
    echo "5. Watch mode (auto-run on changes)"
    echo "6. Exit"
    echo ""
    read -p "Enter option (1-6): " option
    
    case $option in
        1)
            run_all_tests
            ;;
        2)
            run_with_coverage
            ;;
        3)
            run_feature_tests
            ;;
        4)
            run_layer_tests
            ;;
        5)
            echo -e "\n${YELLOW}Starting watch mode...${NC}"
            echo "Press Ctrl+C to exit"
            flutter test --watch
            ;;
        6)
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            show_menu
            ;;
    esac
}

# If no arguments, show menu
if [ $# -eq 0 ]; then
    show_menu
else
    # Handle command line arguments
    case $1 in
        --all|-a)
            run_all_tests
            ;;
        --coverage|-c)
            run_with_coverage
            ;;
        --watch|-w)
            flutter test --watch
            ;;
        --help|-h)
            echo "Usage: ./test_runner.sh [option]"
            echo ""
            echo "Options:"
            echo "  --all, -a        Run all tests"
            echo "  --coverage, -c   Run tests with coverage"
            echo "  --watch, -w      Run in watch mode"
            echo "  --help, -h       Show this help message"
            echo ""
            echo "Without options: Shows interactive menu"
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
fi

echo -e "\n${GREEN}✓ Done!${NC}"








