#include <iostream>
#include <vector>
#include <string>

int main() {
    int count;
    std::cout << "IP 개수: ";
    std::cin >> count;

    std::vector<std::vector<std::string>> ip_list;
    int w = 0;
    while (w < count) {
        std::string a;
        std::cout << "CIDR 입력: ";
        std::cin >> a;

        std::vector<std::string> b(4);
        size_t pos = a.find(".");
        b[0] = a.substr(0, pos);
        size_t prev = pos + 1;
        pos = a.find(".", prev);
        b[1] = a.substr(prev, pos - prev);
        prev = pos + 1;
        pos = a.find(".", prev);
        b[2] = a.substr(prev, pos - prev);
        prev = pos + 1;
        pos = a.find("/", prev);
        b[3] = a.substr(prev, pos - prev);

        std::vector<std::string> c(2);
        c[0] = a.substr(pos + 1);
        c[1] = b[3];

        std::vector<std::string> d;
        d.insert(d.end(), b.begin(), b.end());
        d.insert(d.end(), c.begin(), c.end());
        d.erase(d.begin() + 3);

        std::cout << "[";
        for (const auto& elem : d) {
            std::cout << elem << ", ";
        }
        std::cout << "]" << std::endl;

        ip_list.push_back(d);
        w++;
    }

    std::cout << "현재 추가된 아이피 리스트: ";
    for (const auto& ip : ip_list) {
        std::cout << "[";
        for (const auto& elem : ip) {
            std::cout << elem << ", ";
        }
        std::cout << "]" << std::endl;
    }

    for (const auto& i : ip_list) {
        if (i[4] == "32") {
            std::cout << "정규식 차단이 필요하지 않은 아이피" << std::endl;
        } else if (i[4] == "24") {
            std::cout << i[0] << "\\\\." << i[1] << "\\\\." << i[2] << "(\\\\.[0-9]{1,3})" << std::endl;
        } else if (i[4] == "16") {
            std::cout << i[0] << "\\\\." << i[1] << "(\\\\.[0-9]{1,3}){2}" << std::endl;
        } else if (i[4] == "8") {
            std::cout << i[0] << "(\\\\.[0-9]{1,3}){3}" << std::endl;
        }
    }

    return 0;
}

