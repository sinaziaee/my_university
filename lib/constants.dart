import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kAnimationDuration = Duration(milliseconds: 200);
const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);

final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);
String baseUrl = 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExMVFRUXFxYaFxgYGBgYHRkbHxUXFxgdIB4gICggGholHRUXITEjJiktLi4uFx8zODgsNygtLisBCgoKDg0OGhAQGysiICUtKy4tKy4tLS0tLS0tNzUtLS0tKy0tLS0tKy0tMC0rLS0tLS0tLS0tNS0tLS0tNS0tLf/AABEIAMUA/wMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAAAwQFBgcBAgj/xABKEAABAwICBgYGBgcGBQUAAAABAAIDBBEFEgYhMUFxgQcTUWGRoSIyQlKSsRQjM3KCohU0Q1NiY8EWJLLR4fBkg5Oj8SU1RMLS/8QAGQEBAAMBAQAAAAAAAAAAAAAAAAIDBAEF/8QAKBEAAwABBAIBAwQDAAAAAAAAAAECAwQRITESUUEiMqETFGHRgbHB/9oADAMBAAIRAxEAPwDaUIQgBCEIAQhCAEIQgBCFA4rplQ05ySVLDJujZeR54MYCUBPIVErtPpT+rUEhB/aVD207eOV13ngAq/X6Q4lLtrIqcdlPCXnhnkI8bIDWnOA1k2Heoyq0ko4zlkq6Zh7HTRtPgXLG6vCxLfr5qme+3rZnEHkLC3JJR6PUoFhBHzbf5oDeYKhjxmY9rwdhaQ4eISi+fmaPsYc0Ek1O7beKRzfK9lKUeP4xT+pVsqW+7OwA2+8NZPeUBtqFllH0szM1VmHyNHvwuEg+HaBzKs2D9JGGVBsyqax2zLKDGb9npWBPAoC2oXmKQOF2kOB3gghekAIQhACEIQAhCEAIQhACEIQAhCEAIQhACEJhjmLR0sLp5SQxlr21nW4NFvFAP0nPO1gzPc1rRtLiAPEqmV+nAOqKN3FzrfLWPFV6pxuV5zXDT2ga/iN3eaAv1XpJE0XYySXvADG/G8taRwJVdr9LZzqa+CEfwtdUPtxOSNp+MKqSyOcbuJce0m5XhAOq2oEp+tfPUd00pDOHVRZGEfezJKGcsGWJrIW9kTWx+OUAnmkkIDrjfbrXEIQAhCEAIQhACaVmGQy/aRMd3kC/jtTtCAh6fBHQnNS1NRTnsZIcvNp2qcotMcYgsHGnrGDbmBjkPMavIpNCAslF0twDVV01RTHe7L1jPFuvyVwwfSWkqh/d6iKTuDhm+HasrUfV4JTya3xNv2j0T4ixQG9IWI0U9ZT/AKvXTNA9iTLM384vbgQrHQafVjNU9PFMN7onGN3wOuPzIDS0Kr4fp3SSWzmSA7xKwgD8YuzzVip6uN4DmPY8HYWuBB5hALIQhACEIQAhCEAIQhACYY7AHwSAxtls0kMdscR6QF9xNtR3HWn6EBWRgtLXQsnjLw2Roc1wOuxF9YO/cb9ir2J6AVIuaeojd2NkaR5i/wDTgnegT2MdXUr3BvUVcmQlxackn1rRe42FxVtdRv2x1Dx3ODZG+YDvzIDIavC8Tgv1tA57R7cEjZAfw6nDmFGf2igDskpfC/3ZWOYfMWW0ySVrPYp5hvs58LuQIePFwUbX49HYtrMPqQ3eTC2oYf8Apl5t3loQGdQzteLscHDuIKUU5JgejtU76uSKCX+XKad4/CbC/EJCt6MahovRYiXDc2oAeD2em0X52KAikKPxDDcYpftqJs7R7UBLvIXPkFFRaaQh2WVksTt4c3/Z8kBZUJjSYxBJ6krCey4B8CnyAEIQgBCEIAQhCAEKJr9IqeI5c+d/uRjOfLUmn02tm+yhbA0+1LrdbuaNh4oCwONhc6goyfSCBrsgeZH+7GC8+WocymjNGg83qZpJj7t8rPhCmaWkZGMsbGsHYAAgGkc9RJsjEQ7XnM74Wmw5nku1076eIzNe4vjcyS+y+V7XWsLCxtbgVIKN0lP91nv+7d8kBu9JOJGMeNj2tcOBF/6pVRWikTmUVM13rCCIHjkClUAIQhACEIQAhCEALhKbYnWdVE6TI+QtFwxgu5x3Abr8VUJsRfiLHQytqqCP9pbq3OkadrczS4sFtuobdqAT6PqnrJcSq8rjHPVZWEDMHNiZ1d7DWQTfYNysj20bzYljHdzjC/yLXBJ4T9GhjZT0s0TGsGVsZym3K7XE9907quutZ0EUzewOsTyeLeaARfhUo1w1krRuDwyZvi4ZyPxptJLicWxlLU8HPp3HkRIPNR9VHRs9eCqozfbEJWN5mAmO3HUk6OZz7/Q8YZKb6mTCKW3d6GR/jcoBPFcchcCMQwmoA3uMLKlnxR5j4gKDpqHAZHH6LWOo5CfVZPJAQfuSG1+4BWmTEcXh9ejp6lvvQTGN1vuSauWZQ2L6U4e8WxLDZYre1PSiRo4PYHWPBAO4cBxSP0qXF2zs3MqImP8AGRhzJHEW1zxlrcIpa1u90Ujc3HLIB4Byj6HA8DqDeirHU7zrH0epdE4fhcdR5Kej0dxKH7DFDK3c2qiEmr77S0nigKHiOh+DSevBXYc86/TjkLBzIe23A2UdB0b1BGbDcVgqG7gH5eVgXBaszEcUj1TUUM43mnmDSfwS2/xFIVNZQSOBqqJ0T/elpj6Pb9awODfiCAyqagxqm+3o3yNHtRtbJf4Dq5hNv7XsYcs8UkR72keRAPzW34ZS07xelq5LdjJ+tA/C/MAn0lC8i0nVTN7JIwDzIuD8IQGI02kdK/ZMwdzjl+a91OPUzBczMPc0hx8BrWl4/oTSvic+PD6Xrmem0CNgEhFyWOIAPpC4vuNjuWcVdFRsnilp4YxBVMMkByjMx7TlmiPYWnX4jcgI8YzPL+r05y/vJTkHIbSunA5Jf1mdzx+7j9BnDVrPNTqEA1ocNihFo42t4DX47SnSEIAQm9bXRxC8j2sHef8Ad0zixKSYXp4HFp2SS/Vs4i/pOHALjaXLOpNvZEoouCjfiVQ2kgBMTXA1Eg9WwPqX396c/o5zxaaQu7WsvG3gdZc4cwO5E2kMsQENDUiG37KGKIsHE5dRPe66pWohvZF/7XIluzc42BoDRsAAHIWXpUHQrSioc5kVbIxz5DlYWR5deUkAnNa5sfZV+Vs2qW6Kbioe1AhCFIiCEIQAhCEAzxTFYKZnWTysiZszPcGgnsF9p7gq1UafYRJqdUwvts9Eu8NW1HSRgrZ443mHrnRmwb6J9YgHUd9wPNZ1JURQapInQW96JzR4gW81RkzOHsluacWBWt3Wxd67F6CVv1f0gg9nq/DLdtvwquuqHsP1JygbAC6I/wDacI/GMpnTV8UmtkjHcHApysdanJv6N06TFt7PY00xGHc+Qd7YpxbiOpfzN+Ca1/STTSC2IYbHJsuQ2zvCVjfJ1u9LLj2A6iAR361KdZXyiutDL+1njDcfwR9vo9ZW4c7c3O8MH4SXx+CsdFUYg4XosXoq1vuTtaHW73RG9+IVKq9GqWT1oWg9rfRPkoap0BiJvFK+M7rgOt8j5q+dXD74KK0WRdcmi4lBM79ewCKcb5KZzHniAbOuo6hOFR6op8Rwp3uSdaxoPeJA5nmqhT0mL036vXvI7C91vB1wpKHpAxuIWngjqGjbmjab82G3krllh9MorDkntM0rC3Vjmh1LidJWs/mMbc/8yF1geLCpaLFaxn21EXd9PKyQeD+rdZYyOkahc+9XgzY375IXdW//AAtd+ZWPC+kTDdXV11dTfwyjr2ju9IPIHAqwqNBnq6KU3niDHDYZ4THY9z3C3g5SFNSR2vFI8D+GTOPB2YKAwjSpkuqKtoqruuYH8wS/5BTbGNOt1NlPvMyu82nN5ICQja4bTflYrAOkR5pq2SnbqaKyCpi7hLGWzN4FwB8VvsFtxPA3v56187aW1H0/G5HM1xRvYLjZliGXzfmCAsiFFYppBDCcty+Q7I2a3f6KLNNXVfrn6LEdw1vI8j8lGrmVu2TjHVvaUSeK6RQQanPzP9xnpH/Tmo+KeuqvUApYj7Thd5HcP/HFSmE6N09PrazM/wB9+s/5Dkk6/SNjXGOBpnl91mwfedsCyVqXXGNGydJM85H/AIFsOwGCE5yOsk3yynMeV9Tfn3ppiel0bXZIg6olO5msX7zv5XSBwSpqTerlyM/cx7Obt/mpzD8MigGWJjW942nidpWeqXdvyf4NMTXULxX5K+3DK2q11MghiP7Jm0jsP+pKsGH4bHC0Njba2/enaFXWR1x0i2MSnnt+xljRcIXPj1PjtIz7zCHj/DbmtmwavbUU8M7dksbHj8TQ7+qx7EpQyKRztgY4nwK0ro5hczC6JrtR6iM6+wjMPIhbNG/pZh1y+pFjQhC2mAEIQgBCEIBtidJ1sT47lpc0gOG1p9lw7wbHkojRfHfpdKyWSM5xmjmaAHBsrCWSC221xfZsIVgWeaFukjxPFqZhblbJDKA4E65I7u2EW3ICZxLAsJmP10FOHne5giceBs0kqKqei2DbTVVVB2APErPB4J81bp6mUAh9N1g/lva+/EPy/wBVA1Jw4E9YySkN/WyzUwv2522YfEhcaT7OqmumVOu0GxaLXDNS1I7Hh0TvI5b8SoCunxCn/WMNmAHtRHrBx1XsFp9PSyPGaixXO07A8Q1LDzblefiXZKvF4fWp6WqbvMUj4XH8LwR+ZVPBjfwXTqcq+THoNOKU6ndYw77tvbwupWlx6mk9WZnAmx81csV0mpH3biWE1Mfa6SnEzOT2XuoE6M6M1Z+qnZC87hMYzf7shtyCqejh9F06612kxNrgdYII7l1eJ+hEj0qPEHN+8Nv4mEfJRlToFj0H2ckc4G4OaSeTwPmqq0b+GXTrp+USckTXCzmhw7CAVHT6O0rtsLB90ZfkoipxDFqc2qMPk1e0I3gfELtPivFPpvfU6mlB35fS8jZQ/QzT0WfuMNd/6HM+hNOfVzD/AH3WPml6DCqymN6avnj/AIc+Zvwn0SvEWmdKdTnOYexzSLJ/FpBSu2VEfNwb87J5559jw09eh5U6TY0YnRCWmdnaW9YWOY9txa4ym1++xUBRaNSWIfNkDrXbAMmoCwbmN3ZQBZT8dXG71XsPBwP9UnU4jDGLvlY3i4f7KPUZXwFpsK5/6ecPwqGH7ONoO921x4k6ykMXx2KDU4lzz6sbdbjy3KOlxCoqjlpQYo987xt+4N/H5KQwfAoqf0gC6Q+tI7W4/wCSraS5t7v0WJt8Y1svf9DBtDU1WuocYYt0TD6RH8bv6BTlFRRxNyxsDB3D59qXQoVbfHwTnGp5+fYIQkaqqZG3NI9rGjeTZRS3Jt7Cy8TStaMziGjtJsoCHHJ6uTqcPp3Su2GQghg7/wDyr3oz0WAOE2IymolGsRgkRt5C1/ktEaaq74MuTVxPXJXcOoP0lMymjv1ILX1D9lowdTR3vc23AOW2MYAAALAAADsA1BIUdDHFcRsDcxubcAByAAFk5XoYsaidkeblyvJW7BCEKwqBCEIAUXj2kFPRtDp5A3MbMaNbnnsAGs952DepKR4AJOwAk8BrK+ZsV0ldWVctTJctcS2Ie5GDZoA3X2nvULrxW5OJ8nsa5j3SbAxtoG9Y62tzrsa3+p8l66OsNqHifEZXBk1Y5jg0tuBGxuSO4uCCRrtcbRdZNZrhuI8VPUGllXE0NZM4NAAAOsADis0ajn6jReDj6TZ3z1Lf2Ucg/gkyk/hcLD4k1m0jYzVPDUQ/eidI34os7bcVm8PSbXM2shmHY4Fjj+Jpy/lT6k6a4Qcs9JMw78hY+3JxabLTOSa6ZnrHU9otH0bB6xxc36I+TYXMc1kg7szSHg9yJNCns10uIVlP2Aydez4Zb+RCiZNM8CrdU5iv/wARFkI/ER8inNNopQyelQV00B2/3eqzM5xuLm27rBTICr4cch9WSjrG9j2ugcfAlt/JQeJV4f8A+5aPO7OsibHPb8TbOHJTUuEY1D+r18FQNzaqLKfij/yXkaT4rD+s4X1gA1vpZQ/8rtaAq1E3AnOy09bU4fID6vWSwWPZaQZOSt1DhuItGanxSKqZ2TwtcbdmeNw8SE3dp7hk1mVkT4CfYq6cttzILfNOKPRXCKj6yl6tp256SZ0Z/wC24eaAfR4tiMf21A2Qe9TTsPMslyEcAXLzUYhQS6qmnMZ/n07gB+PKWfmSsWj9TF9jiExG5tQ2OYeIDX253TqKSvZqfHTzDeY3PiJ4McHD86AYt0Yw+dv1YY9nYC2VvwvzAcrJrL0bYe71qWB34DGfFhA/KpZ/UvOaWkex3vGMOI4PjLvmntK2M/Zyu4Z81uIdchAUfGeiHD3xuMUXVSAG1nuIPiVneD4TTMlfC+nY2eI6wQSCL6nNv8txX0QG6rHXyXz/AKcuMNaDr6ymnbE4+/DI0OYT2kNIbftbdZ88NrhmnT2k+UToCF1cXlHsAvE0zWNLnODWjaSbAKAxfSuON3VwtM0vY3WAe8j+irFbnldmq5C87oozZreJ2Dlc96vjA3zXBReoS4nl/gnK/S8vJjo4zI7e86mjv128TYJpgtNSST58UqZXgWNo2uc3hca7fdHiox85IygBrBsa0WH+p7yklplKftRltu/uZ9JaJ4jhpjEdDJBlFvRaQ13Nps6/EKxr5HfGDrI17jsI5qXwrSvEaX7CrkLR7Ehzt872WiciM1YmfUKFh+E9NlQywq6Vrx78V2nwJI+SvGCdK2GVFh1xhd7soy/mF2+asVIqctF4QkqapZI0Oje17TsLSHDxCVXSIIQhARGmEhbQVjm7RTVBHEQvIXy3SD0G8B8l9aV1MJI5IzsexzTwc0tPzXyh9GdE58L/AF4nuY7i0kKrL0XYexWCdzTqPJSlNWNdq2HsUOhZalM1J7FhSNVSMkFnDgdhHNR9NXFuo6x5qThmDhcFVNOSe6ZXquiki1j6yPzCRiZG70m6iN41EHkrUouuwdrjmjOR/dsPEK6cu/fBXWPbrk90OkdfB9jWzt7nOzjwddWXDelzE4rCVsNQBvLercebbDyVD6xzXZJRldu7DwKXV3nSKv05ZrlB010rwG1dJLHfaRllZ8gfIqTp6zR2tIcDStkOw66eS/c4Frr8CsPSclMw7WhSWb2QeD0z6Wp9G8oBpa6pjb2dY2obw+tDjbgbp5GyuZtfTzjva+A+ILwTyC+Y6KeaE3gqJ4be5I5o8AVacN6TsVhsDLHUD+azX4tsVNZJZB4qRvsdc/24JG97S148jm8ku2dj+y/Y4EEcnAELI8P6byNVTQuH8UTw7yI1eJVmw/pewqWwdM+IndJG4DxAIHNSTTINNF8AXz70rTiTF5IWay40bXW7WgvJ5BwWv4hpzQx00lS2pikawXsx7SXHYGgbbk2C+bf09IaiaqcA+plc4jeGX2nvIFgO4Ll9Esf3cmh4ti8VO3NI63Y0a3O4BUrEsamqdpMMPuN9d47zu/3tUV1TnuMkri953k3snCxTjmP5ZvvLV/wj2x4a3LG0Madttp4naeGxeEIUiAIQhACEm+Zo2uA5pfDqaWoNqeGWY3t6DCQD3nYFJS2cdJdnhJSQNO1oKumFdF+JzWLoo6dvbK8E2+6y/mQrjhfQvELGpqpHne2JrY2+Ju75Kax0VvLJkGH1ElM7PBNJCe1jyPEbDzWq9GWm2JVM7YXgVMXtyluQsbr1lzRlcdwFrlT+MaN4VhkHXfQ45ZC5rIWyfWOkld6jQXXtr321AFXLBaR0ULWvyl9rvygNbmO0NA2NGwDsCsUtfJVVp/A+QhCsKgWNdMOhj2ynEIGlzHAfSGi5LSLBsgA3W1O7LA9q2VcIXGt1sdl7Pc+Sl1bnpj0WwVN5KYinm2kAfVvPe32Se0eCxrGsGnpJOqqInRu3X1td3tdscPNZqho1zkVDFdY8g3BsVxCgTJKmxHc/xT5pB1jWq+lYKhzdh5KusfomqJepp2yNyvAIUHU0EkOtt5I+z2m/5hS9PWtdqOop0uTbjgOVXJW4pQ4XBuvaf12ENeczDkf2jYeIUU97mHLKMp3HceatTVdFb3XYshcXUOgvLmA7QCukpB9Ywe0OWtdSfwcbXyBo2e6ErHGG7AAijEsxtBBLKb29BpPyBVkw7o6xeb/4whHbK5rfLW7yVnhbK/OEV5eXPA2kBaVh/QfO6xqK4NG9scZJ8SQB4FWWl6JMJpwHTl0lt80uUHk3KurD7IvP6RhRrGbL3PYNalMNwKuqPsKKd494sLG/E6w81t1NjeB0hy04gc/3aaIzOPEsadfEp8dLKqT9VwyoeNz5nMpmW7fSu/8AKprFJB5qMtw7ojxOWxkdT07d93F7vAC3mFasN6EqcWNTUzSneGWjafmbc1aTBjE22akpB/Ax1Q4c3FrfJcfoc1wvWV1XON+aXqGfDFlFuakpSIOm+2NYtHMDw+xcyljO4zPD3HhnJJ4BSUel8J9Gmgqai2zqYC1nJ78kfLMo2nq8Do3FsQput3iJnXynjlDnk69/apRukk0n6vQVDxudKW07Oea77cGFSIjiOqrpNlPFA3tlkL3D8DBb86dxUcx+0qCe6NjWDxOZ3g4JnEzEJLF76anG9rGvndwzOLAOOUpc0IaLz1Mj/vPETfBmW/O6ApuPt67HqGmNyynifUkE3u65a0694LQtHWd1DIo8epZmOBZNSywjLrGdrs4F+0gnwWiIAQhCAEIQgBM8WwqGpjMU8bZGHc4Xt3jsPeE8QgML016LpqbNLR5p4dZMZ1ysHd+8b+bVvWeMeDsX1uqPpv0bU9beWP6ip/eNHov++3fx2qusafRdGVrswJCe49g1RRSdVVRlh9l4uY3/AHXbDw2pis7lrs0Kk+jqc09a5uo6wmyFFrcluTkFQ12w8l2eBrxlcAQoJptrCfQ4lYenrA3qtw10S8l8kZWUhicQx+rbZ2uyt+jnRhiFZGyYyQwxPF2k5i4jccoGzmqphtO6pngiHrTzNHIuHyFvBfVsdEGxsjaXNYxrWgNNtQFgL7Rs3FbIn2ZMlbdGXUPQfSM9KpqppLayAWxt5kgm3MKTpcN0epDlZHBLI32WtdVP+EBx8lasQoKCOzqjqdR1Gd+bX3dYTrSP9qKdoy08FRN2CCnfl+MhsY5uVxTuIR6SSEAUmGVLm21F7Y6dvg5wcB+FeC7GZdgoaVtt5kqHj/A35pZ+LYjJ9jQMi76mdoPwxh/zSTsJxWX7WvigbvFNACfjlLv8IQ4cdojUy/rGKVZG9sGSnbwu0F1uaYVWBYHTa6l0DnA7amYzOvwe4/JJ4pgGGsH/AKhiMktxrbPV5A7/AJbC2/CySocXweDVRUT53arfRqV8l/xkW5koCRpNNKIDLQ00042AU9MWs+MhrPNLnFsVl+xoIoAfaqprkfgiufzBH6dxKX7DDeqG41MzWavusDjyR+icWl+1r4YBvbTQZj8ct/JoQHf0FiMv2+I9WN7aWFrNXZmkznmoiuw7Bac/3yp+kP8A+JqHTuP4L2v3BqdYjovh7BmxCskm7fpNVkYT9wFrTwsVyg0hwuDVQ0zpjuFJTOff8YaGjiTZAL4fpHCGhuH4bO9u4sgbTM43kyauSeiXFZdkdJSt/jc+of4NyNB5uXj9M4lL9jh7Yh71VMGm3bkjDzyuvbcIxCTXPXiMb200LW8s8md3MWQC40fldrnrqh43tjLYGcsgzj414h/R0T7NMT5R39fL4+k9RGJw4PTk/TKlsr9pbUVDpjxEV8o5NCha3pkw6AZKSCSW2wMY2Jnnr/KgLhpHQGrib1LXslie2WB7hkDZG6wCD6WRwu02GxxTzCNIYZmek5scrTlkic5ocx49Ztr6x2EaiCCsTx/pfrpmlkbYqVjgQT677HVqJ1A27lRqLR6eewp6SeW/thjyONwLKPkS8WfXiFn/AEMYDUUdJJHUtkY8y3a15BAbkbbKATl15r8AtAUiLWwIQhACEIQAhCEAzxbC4amN0U8bZI3bWuF+Y7D3hYrpl0UT02aWhzTw6yYT9owfwn2wPHit2QuNJ9nU2uj5HjkBuNhGog6iDvBG5e19B6a9HVLX3k+xqN0rANfc8bHjz71iGkujVVh78tSz0SbNmZcxu5+ye4qisbXRpjKnwyLSNWfQdwKVXmZt2kdoKrXZY+ixdFVMH4tR32MbI7mI3W8yDyX0lNGHCzr24kfIr5i6OsREGJUMrjZpcY3fjaWD8xHgvqErVHRkvsiDJTRn0Iczv5UJcfiAsOZCSmxKtd9lRBvfPMxmrtAjEhPA2T+erk2Rwuee0lrG+ZzeDSmMseIP2PpYBvs2Sd1u4ksAPEFSIDWTDsTl9ashgb2QwZ3fHI4j8qZVmilM0Zq2uqZba/rakxN+FmRtuSeyaKvkN56+sePdjeyBv/baH/mXqm0Gw9hDvosb3D2pbyu8Xk3QFdpsUwCndanjhlk/kQOqH/GGu83KW/tTVPFqXCqhw3OldHTNt26yXflUhX6T4dRiz54Irey0tvwytVNxbpvoWaoY5pz22DG+evyXNzuzLIYsZl2yUdIP4WvqHeJLRdB0MfJ+tYjWTdrWvFOzwjAPiSs0q+lfFqm4paVkTe3I55HeXH0QOSrNe/Eat2Wpr7k/s2yOkP8A04Q6/gnkjvizYqiPAaA5pPookGvM89dJx15n34KLxHpqoIxlp4pZjuDW9W3z1gclQcJ6MpZNbaapf/FIGU7T8Zc/8t+5XHCuiaX23U0A7GNfO/4n5WX4MC5uxsiCr+mDEprinpo4R265XAeQ8lT8Wx7Eah2WorZXE7I2Otfgxlvktzoui+jb9s6ao32kflZyjjDW+IKtGGYJTU4tBBFEP4GNHna5TZjdej5rwbo9r57GOjksfbmIjHGztZ5BXrB+hOU2NVVhg3sgZr+N3/5W0oTxQ8mVLA+jfDaUhzadsjx7cv1hv2i+oHgFbGtAFgLDsC6hSIghCEAIQhACEIQAhCEAIQhACSqqZkjHRyNa9jhZzXAEEd4SqEBkWlvRCATLh7gBtNO8m34Hn1eB1d4WXVtFJE8sljdG9u1rwWkcuzvGo9q+rlGY7gFNVsyVETX29V2xze9rhrCrrGmWRkcnylIy1xe1zdh7Hbfmvp7QPHxWUEM5IzhoZL3SN1Ov2XOvms40k6GpRmNJMJG+5JZrh3B3qnnZN8G6Ia8tyy1fUMJuWNcX3NrXIFm3tqvc7Fyd0Srxo1TFdMaCnuJaqIEeyHBzvAXKpWMdN9FHcQxSzHt1Mb4m58k4w3oYoWa5nzTnsLsjfBuvzVuwvQ6gp7GGkga4e1ka53xG5U1v8lb8V0ZDV9KuL1WqjpCwHYWQumd4kFvkmEmi+kVd9v1waf3sjYxzaNfiF9EMaBqAAHdqXV3Y5uYHh/QbVGxkmp2dvryH/wCoVvwfogjisX1LiR+6ijj83Z3j4lpqE2Q3ZV6bo/w9ts0JmI2ddI+UDg1xyN5AKw0lJHEMsbGMHY1ob8kuhdOAhCEAIQhACEIQAhCEAIQhACF1CA4hdQgOIXUIDiF1CA4hdQgOIXUIDiF1CA4hdQgOIXUIDiF1CA4hdQgOIXUIDiF1CA4hdQgOIXUIDiF1CA//2Q==';