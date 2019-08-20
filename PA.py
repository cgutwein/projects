#!/user/bin/python

import thingspeak
import ast
import json
import pandas as pd
from time import sleep

master_sensor = {
    'Denver':{'id_primary': 7956, 'id_secondary': 7957, 'label': 'Globeville',
         'A_ch': 436992, 'A_key': 'BCCY1FTDZRPGEZR3',
         'B_ch': 436993, 'B_key': '9D9V11VHM2G8WH4E',
         'C_ch': 436994, 'C_key': 'CJ5CEIFS10V8X3FK',
         'D_ch': 436995, 'D_key': '4D0II3V2DXPTDDWE',
         'lat': 39.785917, 'lon': -104.988855
        },
    'Elmhurst':{'id_primary': 4838, 'id_secondary': 4839, 'label': 'Wheaton Highlands',
         'A_ch': 372220, 'A_key': '6ZX1399UFQ9R3ALG',
         'B_ch': 372221, 'B_key': 'L7GGDWRUO2X0S3XO',
         'C_ch': 372222, 'C_key': 'CIGI45QRYROBXRMN',
         'D_ch': 372223, 'D_key': '12075KOLRICJAD5H',
         'lat': 41.863506, 'lon': -88.08802
        },
    'Chicago':{'id_primary': 5588, 'id_secondary': 5589, 'label': '1138 PLYMOUTH',
         'A_ch': 392051, 'A_key': '9IQJ5SH47AXVZB1J',
         'B_ch': 392052, 'B_key': '1BHKPE2TWHLYLH41',
         'C_ch': 392053, 'C_key': 'BOG4IEYJLYF2AZYO',
         'D_ch': 392054, 'D_key': 'LH3HFMLA1ZZV9JMB',
         'lat': 41.868892, 'lon': -87.629436
        },
    'Mendota Heights':{'id_primary': 3088, 'id_secondary': 3089, 'label': 'Howe Neighborhood',
         'A_ch': 323935, 'A_key': 'LY343R9IG5GOGM1E',
         'B_ch': 323936, 'B_key': 'O0LC54RK57D15YWD',
         'C_ch': 323937, 'C_key': '67RPCHLV0WW761MG',
         'D_ch': 323938, 'D_key': 'K1Y2GIFGIDPA3EAW',
         'lat': 44.935817, 'lon': -93.217521
        },
    'Concord':{'id_primary': 1491, 'id_secondary': 1492, 'label': 'Clean Air Carolina RCCC South Campus',
         'A_ch': 261890, 'A_key': 'FM6RR57XS7UG6Q05',
         'B_ch': 261891, 'B_key': '2YXYFSN80IP14D47',
         'C_ch': 261892, 'C_key': 'N9895O7HBXLPYUQ6',
         'D_ch': 261893, 'D_key': '1M7ED8RRW8MXMC4L',
         'lat': 35.437746, 'lon': -80.659763
        },
    'Evanston':{'id_primary': 4404, 'id_secondary': 4405, 'label': 'Mulford Manor',
         'A_ch': 366382, 'A_key': 'XGMW6CNPVTVT1U5E',
         'B_ch': 366383, 'B_key': '0MJ9GE0C7XCKBDO2',
         'C_ch': 366384, 'C_key': 'R4LKV14C4MZIB0JP',
         'D_ch': 366385, 'D_key': '545UOMASXUTTVWUN',
         'lat': 42.0225, 'lon': -87.763718
        }
}

def procA(row):
    """
    This function takes one row of a Channel A Feed and converts it to a list suitable for appending other channel data.

    args: list
    output: list [timestamp, entry_id, A_PM1_ATM, A_PM25_ATM, A_PM10_ATM, temp, humidity, A_PM25_1]
    """
    return [row[0], row[1], float(row[2]), float(row[3]), float(row[4]), int(row[7]), int(row[8]), float(row[9])]

def procB(row):
    """
    This function takes one row of a Channel B Feed and converts it to a list suitable for appending to a Channel A processed list.

    args: list
    output: list [A_PM1_1, A_PM10_1]
    """
    return [float(row[8]), float(row[9])]

def procC(row):
    """
    This function takes one row of a Channel C Feed and converts it to a list suitable for appending to a Channel AB processed list.

    args: list
    output: list [B_PM1_ATM, B_PM25_ATM, B_PM10_ATM, B_PM25_1]
    """
    return [float(row[2]), float(row[3]), float(row[4]), float(row[9])]

def procD(row):
    """
    This function takes one row of a Channel D Feed and converts it to a list suitable for appending to a Channel ABC processed list.

    args: list
    output: list [B_PM1_1, B_PM10_1]
    """
    return [float(row[8]), float(row[9])]

def PA_sensor_pull(label):
    """
    Get one full row of data for a single Purple Air sensor.

    args: dictionary key, string (e.g. 'Denver')
    output: string, SQL command to add one row of data to PostgreSQL database
    """
    sensor_id = master_sensor[label]['id_primary']
    final_row = [sensor_id]
    for key in key_list:
        channel_id = master_sensor[label][key[0]]
        read_key = master_sensor[label][key[1]]
        channel = thingspeak.Channel(id=channel_id,api_key=read_key)
        try:
            f_ = list(json.loads(channel.get(options = {'results': 1}))['feeds'][0].values())
            final_row.extend(key[2](f_))
        except:
            pass

    psql_input = "INSERT INTO sensor_data1 (sensor_id, created_on, entry_id, A_PM1_ATM, A_PM25_ATM, A_PM10_ATM, temp, humidity, A_PM25_1,\
A_PM1_1, A_PM10_1,B_PM1_ATM, B_PM25_ATM, B_PM10_ATM, B_PM25_1,B_PM1_1, B_PM10_1) VALUES " + str(tuple(final_row)) + ";"

    return(psql_input)

def write_feed(key_list):
    """
    Writes five sensor feed to database

    args; list of keys for master
    output, none
    """
    conn = psycopg2.connect(host="35.232.198.24",database="postgres", user="postgres", password="9eEBOdleImHrPDaq")
    for key in key_list:
        sql = PA_sensor_pull(key)
        conn = psycopg2.connect(host="35.232.198.24",database="postgres", user="postgres", password="9eEBOdleImHrPDaq")
        cur = conn.cursor()
        cur.execute(sql)
        conn.commit()
        cur.close()
        conn.close()
        print("Data for " + key + "written to database.")

key_list = [('A_ch','A_key', procA), ('B_ch','B_key', procB), ('C_ch','C_key', procC), ('D_ch','D_key', procD)]
