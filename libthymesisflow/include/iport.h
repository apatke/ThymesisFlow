/// @file iport.h
#if !defined(IPORT_H)
#define IPORT_H

#include "logger.h"
#include <stdio.h>
#include <stdlib.h>

struct port_s {
    int nport;
    struct port_s *next;
};

typedef struct port_s iport_list;

/**
 * Print interface (AFU) ports
 *
 * @param[in] iport_list: list of ports passed in the socket request
 */
void cycle_ports(iport_list *pl);

/**
 * Add port to the list
 *
 * @param[in] iport_list: list of ports
 * @param[in] port_number: port number
 */
iport_list *add_port(iport_list *pl, u_int8_t port_number);

/**
 * Convert from binary representation of the ports to list structure
 *
 * @param[in] n: binary representation of the porst.
 */
iport_list *unmarshal_iports(u_int8_t n);

/**
 * Free dynamically allocated list structure
 *
 * @param[in] iport_list: list of port numbers
 */
void free_iport_list(iport_list *pl);

/**
 * Convert port list to binary represetnation
 *
 * @param[in] iport_list: list of port numbers
 * @param[out] binary_rep: binary representation of the ports currently in use
 */
u_int8_t marshal_iports(const iport_list *pl);
#endif
